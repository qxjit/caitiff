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

  def fallacies
    @results.select {|result| result.is_a?(Fallacy)}
  end
end

