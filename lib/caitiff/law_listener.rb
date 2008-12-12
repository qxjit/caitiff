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

