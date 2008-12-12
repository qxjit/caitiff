class Law
  def initialize(expression)
    @expression = expression
  end

  def line_number
    eval("__LINE__", @expression.binding)
  end

  def filename
    eval("__FILE__", @expression.binding)
  end

  def source
    File.open(filename) do |file|
      (line_number - 1).times {file.readline}
      source = file.readline
      while((l = file.readline) && l !~ /\s*law/)
        source << l
      end
      source.strip
    end
    "law { Law.new(proc {true}).source ==\n      expected_source }"
  end

  def prove_or_disprove
    begin
      if @expression.call
        Truth.new
      else
        Fallacy.new
      end
    rescue Exception
      Fallacy.new
    end
  end
end

class Truth
  def plural_name
    "truths"
  end

  def summary_importance
    1.0
  end
end

class Fallacy
  def plural_name
    "fallacies"
  end

  def summary_importance
    0.0
  end
end

class Summary
  def initialize(results)
    @results = results
  end

  def to_s
    names = @results.sort_by {|r| -r.summary_importance}.
                     map {|r| r.plural_name}.
                     uniq

    summary = "#{@results.size} laws"

    names.each do |name|
      summary << ", " 
      summary << @results.find_all {|r| r.plural_name == name}.size.to_s
      summary << " " << name
    end

    summary
  end

  def ==(other)
    other.to_s == self.to_s
  end
end

class Judge
  def initialize
    @results = []
  end

  def on_law(law)
    @results << law.prove_or_disprove
  end

  def summary
    Summary.new(@results)
  end
end

module LawListener
  @stack = []

  def self.current
    @stack.last
  end

  def self.with_current(listener)
    @stack.push listener
    begin
      yield
    ensure
      @stack.pop
    end
  end
end

def law(&block)
  LawListener.current.on_law(Law.new(block))
end

