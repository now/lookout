# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [Lookout::Diff::Match.new(0, 0, 2), Lookout::Diff::Match.new(3, 2, 2)] do
    Lookout::Diff::Matches.new('abxcd', 'abcd').to_a
  end

  expect [Lookout::Diff::Match.new(0, 0, 1),
          Lookout::Diff::Match.new(2, 2, 1),
          Lookout::Diff::Match.new(4, 3, 2)] do
    Lookout::Diff::Matches.new('acbxcd', 'aybcd').to_a
  end

  expect [Lookout::Diff::Match.new(1, 0, 2),
          Lookout::Diff::Match.new(4, 3, 2)] do
    Lookout::Diff::Matches.new('qabxcd', 'abycdf').to_a
  end

  expect [Lookout::Diff::Match.new(1, 0, 2),
          Lookout::Diff::Match.new(4, 3, 2)] do
    Lookout::Diff::Matches.new('qabxcd', 'abycdf').to_a
  end

  expect [Lookout::Diff::Match.new(0, 0, 8),
          Lookout::Diff::Match.new(8, 17, 6),
          Lookout::Diff::Match.new(14, 23, 15)] do
    Lookout::Diff::Matches.new('private Thread currentThread;',
                               'private volatile Thread currentThread;'){ |c|
      c == ' '[0]
    }.to_a
  end
end
