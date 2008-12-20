class ProcResults
  attr_reader :value, :receiver, :arguments, :method_name

  def self.collect(block)
    block_sexp = block.to_sexp

    last_sexp = if block_sexp[3][0] == :block
                  block_sexp[3].pop
                else
                  block_sexp[3] = Sexp.from_array [:block, block_sexp[3]]
                  block_sexp[3].pop
                end

    if last_sexp[0] == :call
      block_sexp[3].push Sexp.from_array([:lasgn, :__receiver__, 
                                                  last_sexp[1] || [:nil]])

      last_sexp[1] = Sexp.from_array [:lvar, :__receiver__] if last_sexp[1]

      arguments_capture_sexp = Sexp.from_array [:array]

      1.upto(last_sexp[3].size - 1) do |arg_index|
        block_sexp[3].push Sexp.from_array([:lasgn, 
                                              :"__arg#{arg_index}__", 
                                              last_sexp[3][arg_index]])
        last_sexp[3][arg_index] = Sexp.from_array [:lvar, :"__arg#{arg_index}__"]
        arguments_capture_sexp.push Sexp.from_array([:lvar, :"__arg#{arg_index}__"])
      end

      block_sexp[3].push Sexp.from_array([:call, [:const, :ProcResults],
                                                 :new,
                                                 [:arglist, 
                                                    last_sexp, 
                                                    [:lvar, :__receiver__],
                                                    arguments_capture_sexp,
                                                    [:lit, last_sexp[2]]]])
    else
      block_sexp[3].push Sexp.from_array([:call, [:const, :ProcResults],
                                                 :new,
                                                 [:arglist, 
                                                    last_sexp, 
                                                    [:nil], 
                                                    [:nil],
                                                    [:nil]]])
    end

    ruby_returning_proc_result = Ruby2Ruby.new.process(block_sexp)
    block_returning_proc_result = eval ruby_returning_proc_result, block.binding
    block_returning_proc_result.call
  end

  def initialize(value, receiver, arguments, method_name)
    @value = value
    @receiver = receiver
    @arguments = arguments
    @method_name = method_name
  end

  def to_s
    if receiver
      Ruby2Ruby.new.process [:call, [:lit, receiver], 
                                    method_name, 
                                    [:arglist, 
                                      *arguments.map {|a| [:lit, a]}]]
    else
      @value.inspect
    end
  end
end

