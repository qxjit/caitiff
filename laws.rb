law { 2 + 3 == 5 }
law { Truth.new.plural_name == "truths" }
law { Truth.new.summary_importance == 1.0 }
law { Fallacy.new.plural_name == "fallacies" }
law { Fallacy.new.summary_importance == 0.0 }
law { Law.new(proc {true}).prove_or_disprove.is_a?(Truth) }
law { Law.new(proc {false}).prove_or_disprove.is_a?(Fallacy) }

law { Summary.new([Truth.new, Truth.new, Fallacy.new]).to_s == 
      "3 laws, 2 truths, 1 fallacies" }

law { Summary.new([Truth.new, Fallacy.new]) == 
      Summary.new([Fallacy.new, Truth.new]) }

law { Summary.new([Truth.new, Truth.new]) != 
      Summary.new([Fallacy.new, Truth.new]) }

law { !LawListener.current.nil? }

law { current_in_block = nil
      LawListener.with_current(:mine) {current_in_block = LawListener.current}
      current_in_block == :mine }

law { original = LawListener.current
      LawListener.with_current(:mine) {LawListener.with_current(:yours) {}}
      original == LawListener.current }

law { original = LawListener.current
      LawListener.with_current(:mine) {raise} rescue nil
      original == LawListener.current }

law { (judge = Judge.new).on_law(Law.new(proc {false}))
      judge.summary == Summary.new([Fallacy.new]) }

law { LawListener.with_current(judge = Judge.new) { law {false} }
      judge.summary == Summary.new([Fallacy.new]) }
      
