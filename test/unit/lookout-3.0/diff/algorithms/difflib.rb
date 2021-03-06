# -*- coding: utf-8 -*-

Expectations do
  expect [Lookout::Diff::Match.new(Lookout::Diff::Slice.new('abxcd', 0..1),
                                   Lookout::Diff::Slice.new('abcd', 0..1)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('abxcd', 3..4),
                                   Lookout::Diff::Slice.new('abcd', 2..3)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('abxcd', 5...5),
                                   Lookout::Diff::Slice.new('abcd', 4...4))] do
    Lookout::Diff::Algorithms::Difflib.new('abxcd', 'abcd').to_a
  end

  expect [Lookout::Diff::Match.new(Lookout::Diff::Slice.new('acbxcd', 0..0),
                                   Lookout::Diff::Slice.new('aybcd', 0..0)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('acbxcd', 2..2),
                                   Lookout::Diff::Slice.new('aybcd', 2..2)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('acbxcd', 4..5),
                                   Lookout::Diff::Slice.new('aybcd', 3..4)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('acbxcd', 6...6),
                                   Lookout::Diff::Slice.new('aybcd', 5...5))] do
    Lookout::Diff::Algorithms::Difflib.new('acbxcd', 'aybcd').to_a
  end

  expect [Lookout::Diff::Match.new(Lookout::Diff::Slice.new('qabxcd', 1..2),
                                   Lookout::Diff::Slice.new('abycdf', 0..1)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('qabxcd', 4..5),
                                   Lookout::Diff::Slice.new('abycdf', 3..4)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('qabxcd', 6...6),
                                   Lookout::Diff::Slice.new('abycdf', 6...6))] do
    Lookout::Diff::Algorithms::Difflib.new('qabxcd', 'abycdf').to_a
  end

  expect [Lookout::Diff::Match.new(Lookout::Diff::Slice.new('abxcd', 0..1),
                                   Lookout::Diff::Slice.new('abcd', 0..1)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('abxcd', 3..4),
                                   Lookout::Diff::Slice.new('abcd', 2..3)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('abxcd', 5...5),
                                   Lookout::Diff::Slice.new('abcd', 4...4)),] do
    Lookout::Diff::Algorithms::Difflib.new('abxcd', 'abcd').to_a
  end

  # 0, 0, 8
  # 8, 17, 21
  # 29, 38, 0
  expect [Lookout::Diff::Match.new(Lookout::Diff::Slice.new('private Thread currentThread;', 0..7),
                                   Lookout::Diff::Slice.new('private volatile Thread currentThread;', 0..7)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('private Thread currentThread;', 8..28),
                                   Lookout::Diff::Slice.new('private volatile Thread currentThread;', 17..37)),
          Lookout::Diff::Match.new(Lookout::Diff::Slice.new('private Thread currentThread;', 29...29),
                                   Lookout::Diff::Slice.new('private volatile Thread currentThread;', 38...38))] do
    Lookout::Diff::Algorithms::Difflib.new('private Thread currentThread;',
                                           'private volatile Thread currentThread;'){ |c|
      c == ' '[0]
    }.to_a
  end
end
