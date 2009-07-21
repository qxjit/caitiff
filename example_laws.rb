law { 2 * 3 == 10 / 2 }
law { 2 * 3 == 6 }

__END__
When judged, this file produces the following:

Fallacy: ./example_laws.rb:1
  law { 2 * 3 == 10 / 2 }
  ----
  (6 == 5)

2 laws, 1 truths, 1 fallacies

