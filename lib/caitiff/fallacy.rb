class Fallacy
  attr_reader :law

  def initialize(law = Law::FalseLaw)
    @law = law
  end

  def plural_name
    "fallacies"
  end

  def summary_importance
    0.0
  end
end

