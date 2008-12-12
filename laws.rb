2 + 2 == 5
2 + 3 == 5
Truth.new.plural_name == "truths"
Truth.new.summary_importance == 1.0
Fallacy.new.plural_name == "fallacies"
Fallacy.new.summary_importance == 0.0
Law.new("1 == 1").prove_or_disprove.is_a?(Truth)
Law.new("1 == 2").prove_or_disprove.is_a?(Fallacy)
Summary.new([Truth.new, Truth.new, Fallacy.new]).to_s == "3 laws, 2 truths, 1 fallacies"
