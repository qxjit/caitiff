class Law
  def initialize(expression)
    @expression = expression
  end

  def prove_or_disprove
    if @expression.call
      Truth.new
    else
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

LawListener.with_current(judge = Judge.new) do
  require 'laws.rb'
end

puts judge.summary
