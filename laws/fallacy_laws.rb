law { Fallacy.new.plural_name == "fallacies" }
law { Fallacy.new.summary_importance == 0.0 }

law { Fallacy.new.law == Law::FalseLaw }
law { Fallacy.new(law = Law.new(proc {false})).law == law }
