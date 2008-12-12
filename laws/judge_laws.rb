law { (judge = Judge.new).on_law(Law.new(proc {false}))
      judge.summary == Summary.new([Fallacy.new]) }

law { LawListener.with_current(judge = Judge.new) { law {false} }
      judge.summary == Summary.new([Fallacy.new]) }
