class Fallacy
  attr_reader :law, :details

  def initialize(law = Law::FalseLaw, details = "")
    @law = law
    @details = details
  end

  def plural_name
    "fallacies"
  end

  def summary_importance
    0.0
  end
end

