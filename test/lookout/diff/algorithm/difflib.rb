# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [Lookout::Diff::Match.new(0, 0, 2),
          Lookout::Diff::Match.new(3, 2, 2),
          Lookout::Diff::Match.new(5, 4, 0)] do
    Lookout::Diff::Algorithm::Difflib.new('abxcd', 'abcd').to_a
  end

  expect [Lookout::Diff::Match.new(0, 0, 1),
          Lookout::Diff::Match.new(2, 2, 1),
          Lookout::Diff::Match.new(4, 3, 2),
          Lookout::Diff::Match.new(6, 5, 0)] do
    Lookout::Diff::Algorithm::Difflib.new('acbxcd', 'aybcd').to_a
  end

  expect [Lookout::Diff::Match.new(1, 0, 2),
          Lookout::Diff::Match.new(4, 3, 2),
          Lookout::Diff::Match.new(6, 6, 0)] do
    Lookout::Diff::Algorithm::Difflib.new('qabxcd', 'abycdf').to_a
  end

  expect [Lookout::Diff::Match.new(1, 0, 2),
          Lookout::Diff::Match.new(4, 3, 2),
          Lookout::Diff::Match.new(6, 6, 0)] do
    Lookout::Diff::Algorithm::Difflib.new('qabxcd', 'abycdf').to_a
  end

  expect [Lookout::Diff::Match.new(0, 0, 2),
          Lookout::Diff::Match.new(3, 2, 2),
          Lookout::Diff::Match.new(5, 4, 0)] do
    Lookout::Diff::Algorithm::Difflib.new('abxcd', 'abcd').to_a
  end

  expect [Lookout::Diff::Match.new(0, 0, 8),
          Lookout::Diff::Match.new(8, 17, 21),
          Lookout::Diff::Match.new(29, 38, 0)] do
    Lookout::Diff::Algorithm::Difflib.new('private Thread currentThread;',
                                          'private volatile Thread currentThread;'){ |c|
      c == ' '[0]
    }.to_a
  end
end
