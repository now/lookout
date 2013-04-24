# -*- coding: utf-8 -*-

Expectations do
  expect [] do
    Lookout::Diff::Operations.new(Lookout::Diff::Algorithms::Difflib.new('',
                                                                         '')).to_a
  end

  expect [Lookout::Diff::Operations::Delete.new(Lookout::Diff::Slice.new('qabxcd', 0..0),
                                                Lookout::Diff::Slice.new('abycdf', 0...0)),
          Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('qabxcd', 1..2),
                                              Lookout::Diff::Slice.new('abycdf', 0..1)),
          Lookout::Diff::Operations::Replace.new(Lookout::Diff::Slice.new('qabxcd', 3..3),
                                                 Lookout::Diff::Slice.new('abycdf', 2..2)),
          Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('qabxcd', 4..5),
                                              Lookout::Diff::Slice.new('abycdf', 3..4)),
          Lookout::Diff::Operations::Insert.new(Lookout::Diff::Slice.new('qabxcd', 6...6),
                                                Lookout::Diff::Slice.new('abycdf', 5..5))] do
    Lookout::Diff::Operations.new(Lookout::Diff::Algorithms::Difflib.new('qabxcd',
                                                                         'abycdf')).to_a
  end
end
