law { Truth.new.plural_name == "truths" }
law { Truth.new.summary_importance == 1.0 }
law { Truth.new.law == Law::TrueLaw }
law { Truth.new(law = Law.new(proc {true})).law == law }

