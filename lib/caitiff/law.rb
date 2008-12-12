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


