
law {ProcResults.collect(proc {true}).value == true}

law {ProcResults.collect(proc {1 == 2}).receiver == 1}
law {ProcResults.collect(proc {1 == 2}).method_name == :==}
law {ProcResults.collect(proc {1 == 2}).arguments == [2]}

law {ProcResults.collect(proc {x = 1; y = 2; y == x}).receiver == 2}
law {ProcResults.collect(proc {x = 1; y = 2; y == x}).arguments == [1]}
law {ProcResults.collect(proc {x = 1; y = 2; x == y}).to_s == "(1 == 2)"}

def fcall_method(*args); true; end
law {ProcResults.collect(proc {fcall_method("1")}).receiver == self}
law {ProcResults.collect(proc {fcall_method("1")}).method_name == :fcall_method}
law {ProcResults.collect(proc {fcall_method("1")}).arguments == ["1"]}
law {ProcResults.collect(proc {fcall_method("1")}).to_s == 'main.fcall_method("1")'}

def vcall_method; true; end
law {ProcResults.collect(proc {vcall_method}).receiver == self}
law {ProcResults.collect(proc {vcall_method}).method_name == :vcall_method}
law {ProcResults.collect(proc {vcall_method}).arguments == []}
law {ProcResults.collect(proc {vcall_method}).to_s == "main.vcall_method"}

law {ProcResults.collect(proc {true}).receiver == nil}
law {ProcResults.collect(proc {true}).arguments == nil}
law {ProcResults.collect(proc {true}).to_s == "true"}

var_in_context = 10
law {ProcResults.collect(proc {var_in_context == 10}).receiver == 10}

law {ProcResults.collect(proc {[1, 2, 3][1,2]}).arguments == [1,2]}

law {ProcResults.collect(proc {[].empty?}).arguments == []}
law {ProcResults.collect(proc {[].empty?}).to_s == "[].empty?"}

law {ProcResults.collect(proc {nil == nil}).to_s == "(nil == nil)"}

law {p = proc {1 == 2}
     ProcResults.collect(p)
     ProcResults.collect(p).arguments == [2]}

