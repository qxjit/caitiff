law { Summary.new([Truth.new, Truth.new, Fallacy.new]).to_s == 
      "3 laws, 2 truths, 1 fallacies" }

law { Summary.new([Truth.new, Fallacy.new]) == 
      Summary.new([Fallacy.new, Truth.new]) }

law { Summary.new([Truth.new, Truth.new]) != 
      Summary.new([Fallacy.new, Truth.new]) }

