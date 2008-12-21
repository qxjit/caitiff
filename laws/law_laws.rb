law { Law.new(proc {true}).prove_or_disprove.is_a?(Truth) }
law { Law.new(proc {false}).prove_or_disprove.is_a?(Fallacy) }
law { Law.new(proc {raise Exception}).prove_or_disprove.is_a?(Fallacy) }

law { (law = Law.new(proc {true})).prove_or_disprove.law == law }
law { (law = Law.new(proc {false})).prove_or_disprove.law == law }
law { (law = Law.new(proc {raise Exception})).prove_or_disprove.law == law }

expected_source = "law { Law.new(proc {true}).source ==
      expected_source }"
law { Law.new(proc {true}).source ==
      expected_source }

law { Law.new(proc {true}).line_number == __LINE__ }
law { Law.new(proc {true}).filename == __FILE__ }

law { Law::TrueLaw.prove_or_disprove.is_a?(Truth) }
law { Law::FalseLaw.prove_or_disprove.is_a?(Fallacy) }

law { Law.new(proc {x = 1; y = 2; x == y;}).prove_or_disprove.
        details == "(1 == 2)" }

