law {ProcResults.collect(proc {true}).value == true}
law {ProcResults.collect(proc {1 == 2}).receiver == 1}
law {ProcResults.collect(proc {x = 1; y = 2; y == x}).receiver == 2}
law {ProcResults.collect(proc {true}).receiver == nil}

var_in_context = 10
law {ProcResults.collect(proc {var_in_context == 10}).receiver == 10}

law {ProcResults.collect(proc {1 == 2}).arguments == [2]}
law {ProcResults.collect(proc {x = 1; y = 2; y == x}).arguments == [1]}
law {ProcResults.collect(proc {true}).arguments == nil}
law {ProcResults.collect(proc {[1, 2, 3][1,2]}).arguments == [1,2]}
law {ProcResults.collect(proc {[].empty?}).arguments == nil}

law {ProcResults.collect(proc {1 == 2}).method_name == :==}

