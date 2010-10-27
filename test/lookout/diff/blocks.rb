# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [Lookout::Diff::Match.new(0, 0, 2),
          Lookout::Diff::Match.new(3, 2, 2),
          Lookout::Diff::Match.new(5, 4, 0)] do
    Lookout::Diff::Blocks.diff('abxcd', 'abcd').to_a
  end

  # TODO: Need to make sure that matches are joined when they should be.  I
  # can’t come up with any examples were this would need to be done, though.
  expect [Lookout::Diff::Match.new(0, 0, 8),
          Lookout::Diff::Match.new(8, 17, 21),
          Lookout::Diff::Match.new(29, 38, 0)] do
    Lookout::Diff::Blocks.diff('private Thread currentThread;',
                               'private volatile Thread currentThread;'){ |c|
      c == ' '[0]
    }.to_a
  end
end
