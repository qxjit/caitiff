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

$results = []

def law(&block)
  $results << Law.new(block).prove_or_disprove
end

require 'laws.rb'

puts Summary.new($results)
