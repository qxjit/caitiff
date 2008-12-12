law { Law.new(proc {true}).prove_or_disprove.is_a?(Truth) }
law { Law.new(proc {false}).prove_or_disprove.is_a?(Fallacy) }
law { Law.new(proc {raise Exception}).prove_or_disprove.is_a?(Fallacy) }

expected_source = "law { Law.new(proc {true}).source ==
      expected_source }"
law { Law.new(proc {true}).source ==
      expected_source }

law { Law.new(proc {true}).line_number == __LINE__ }
law { Law.new(proc {true}).filename == __FILE__ }
