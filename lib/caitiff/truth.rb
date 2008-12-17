class Truth
  attr_reader :law

  def initialize(law = Law::TrueLaw)
    @law = law
  end

  def plural_name
    "truths"
  end

  def summary_importance
    1.0
  end
end


