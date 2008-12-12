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

