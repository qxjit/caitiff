law { (judge = Judge.new).on_law(Law.new(proc {false}))
      judge.summary == Summary.new([Fallacy.new]) }

law { LawListener.with_current(judge = Judge.new) { law {false} }
      judge.summary == Summary.new([Fallacy.new]) }

law { LawListener.with_current(judge = Judge.new) { law {false}; law {true} }
      judge.fallacies.size == 1 && judge.fallacies.first.is_a?(Fallacy) }
