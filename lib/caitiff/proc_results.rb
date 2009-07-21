class ProcResults
  attr_reader :value, :receiver, :arguments, :method_name, :starting_line

  inline do |builder|
    builder.include '"node.h"'
    builder.include '"env.h"'

    builder.prefix %{
      struct BLOCK {
          NODE *var;
          NODE *body;
          VALUE self;
          struct FRAME frame;
          struct SCOPE *scope;
          VALUE klass;
          NODE *cref;
          int iter;
          int vmode;
          int flags;
          int uniq;
          struct RVarmap *dyna_vars;
          VALUE orig_thread;
          VALUE wrapper;
          VALUE block_obj;
          struct BLOCK *outer;
          struct BLOCK *prev;
      };
    } unless RUBY_VERSION >= "1.9" # matz added this to env.h for ParseTree

    builder.prefix %{
    }

    builder.c_singleton %Q{
      static VALUE rewrite_to_record_last_call(VALUE block) {
        struct BLOCK *data;
        Data_Get_Struct(block, struct BLOCK, data);
        NODE *last_node = data->body;

        while(nd_type(last_node) == NODE_NEWLINE) {
          last_node = last_node->nd_next;
        }

        if (nd_type(last_node) == NODE_BLOCK) {
          while(last_node->nd_next) {
            last_node = last_node->nd_next;
          }

          while(nd_type(last_node) == NODE_BLOCK) {
            last_node = last_node->nd_head;
          }

          while(nd_type(last_node) == NODE_NEWLINE) {
            last_node = last_node->nd_next;
          }
        }

        if(nd_type(last_node) == NODE_FCALL ||
           nd_type(last_node) == NODE_VCALL) {
          last_node->nd_recv = NEW_SELF();
          nd_set_type(last_node, NODE_CALL);
        }

        if(nd_type(last_node) == NODE_CALL) {
          if (nd_type(last_node->nd_recv) == NODE_CONST &&
              last_node->nd_recv->nd_vid == rb_intern("ProcResults")) {
            return Qnil;
          }

          ID original_mid = last_node->nd_mid;
          NODE *new_args = NEW_ARRAY(NEW_LIT(ID2SYM(original_mid)));

          new_args->nd_next = last_node->nd_args;
          if (last_node->nd_args) {
            new_args->nd_alen = last_node->nd_args->nd_alen + 1;
          } 
          last_node->nd_args = new_args;

          new_args = NEW_ARRAY(last_node->nd_recv);

          new_args->nd_next = last_node->nd_args;
          new_args->nd_alen = last_node->nd_args->nd_alen + 1;
          last_node->nd_args = new_args;

          new_args = NEW_ARRAY(NEW_LIT(INT2FIX(nd_line(last_node->nd_recv))));

          new_args->nd_next = last_node->nd_args;
          new_args->nd_alen = last_node->nd_args->nd_alen + 1;
          last_node->nd_args = new_args;

          last_node->nd_recv = NEW_CONST(rb_intern("ProcResults"));
          last_node->nd_mid = rb_intern("record");
        }

        return Qnil;
      }
    }
  end

  def self.record(starting_line, receiver, method_name, *arguments)
    value = receiver.send(method_name, *arguments)
    new(value, receiver, arguments, method_name, starting_line)
  end

  def self.collect(block)
    rewrite_to_record_last_call(block)
    raw_result = block.call

    if raw_result.is_a?(ProcResults)
      raw_result
    else
      ProcResults.new(raw_result, nil, nil, nil, nil)
    end
  end

  def initialize(value, receiver, arguments, method_name, starting_line)
    @value = value
    @receiver = receiver
    @arguments = arguments
    @method_name = method_name
    @starting_line = starting_line
  end

  def to_s
    if method_name
      Ruby2Ruby.new.process [:call, [:lit, receiver], 
                                    method_name, 
                                    [:arglist, 
                                      *arguments.map {|a| [:lit, a]}]]
    else
      @value.inspect
    end
  end
end

