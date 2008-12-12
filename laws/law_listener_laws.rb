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

