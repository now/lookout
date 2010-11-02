# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [] do
    Lookout::Diff::Operations.new(Lookout::Diff::Algorithms::Difflib.new('',
                                                                         '')).to_a
  end

  expect [Lookout::Diff::Operations::Delete.new(Lookout::Diff::Range.new('qabxcd', 0..0),
                                                Lookout::Diff::Range.new('abycdf', 0...0)),
          Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('qabxcd', 1..2),
                                               Lookout::Diff::Range.new('abycdf', 0..1)),
          Lookout::Diff::Operations::Replace.new(Lookout::Diff::Range.new('qabxcd', 3..3),
                                                 Lookout::Diff::Range.new('abycdf', 2..2)),
          Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('qabxcd', 4..5),
                                               Lookout::Diff::Range.new('abycdf', 3..4)),
          Lookout::Diff::Operations::Insert.new(Lookout::Diff::Range.new('qabxcd', 6...6),
                                                Lookout::Diff::Range.new('abycdf', 5..5))] do
    Lookout::Diff::Operations.new(Lookout::Diff::Algorithms::Difflib.new('qabxcd',
                                                                         'abycdf')).to_a
  end
end
