class Fallacy
  attr_reader :law, :details, :error

  def initialize(law = Law::FalseLaw, details = nil, error = nil)
    @law = law
    @details = details
    @error = error
  end

  def plural_name
    "fallacies"
  end

  def summary_importance
    0.0
  end
end

