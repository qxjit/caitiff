law { 2 + 2 == 5 }
law { 2 + 3 == 5 }
law { Truth.new.plural_name == "truths" }
law { Truth.new.summary_importance == 1.0 }
law { Fallacy.new.plural_name == "fallacies" }
law { Fallacy.new.summary_importance == 0.0 }
law { Law.new(proc {1 == 1}).prove_or_disprove.is_a?(Truth) }
law { Law.new(proc {1 == 2}).prove_or_disprove.is_a?(Fallacy) }
law { Summary.new([Truth.new, Truth.new, Fallacy.new]).to_s == "3 laws, 2 truths, 1 fallacies" }
law { Summary.new([Truth.new, Fallacy.new]) == Summary.new([Fallacy.new, Truth.new]) }
law { Summary.new([Truth.new, Truth.new]) != Summary.new([Fallacy.new, Truth.new]) }
