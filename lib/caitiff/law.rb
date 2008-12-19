class Law
  def initialize(expression)
    @expression = expression
  end

  TrueLaw = Law.new(proc {true})
  FalseLaw = Law.new(proc {false})

  def line_number
    eval("__LINE__", @expression.binding)
  end

  def filename
    eval("__FILE__", @expression.binding)
  end

  def source
    File.open(filename) do |file|
      (line_number - 1).times {file.gets}
      source = file.gets
      while((l = file.gets) && l !~ /\s*law/)
        source << l
      end
      source.strip
    end
  end

  def prove_or_disprove
    begin
      if @expression.call
        Truth.new(self)
      else
        Fallacy.new(self)
      end
    rescue Exception
      Fallacy.new(self)
    end
  end
end

