# -*- coding: utf-8 -*-

Expectations do
  expect false do
    Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('', 0...0),
                                         Lookout::Diff::Range.new('', 0...0)).foldable? 0
  end

  expect true do
    Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('ab', 0..1),
                                         Lookout::Diff::Range.new('ab', 0..1)).foldable? 1
  end

  expect Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('', 0...0),
                                              Lookout::Diff::Range.new('', 0...0)) do
    Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('', 0...0),
                                         Lookout::Diff::Range.new('', 0...0)) >> 1
  end

  expect Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('abc', 2..2),
                                              Lookout::Diff::Range.new('abc', 2..2)) do
    Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('abc', 0..2),
                                         Lookout::Diff::Range.new('abc', 0..2)) >> 1
  end

  expect Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('', 0...0),
                                              Lookout::Diff::Range.new('', 0...0)) do
    Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('', 0...0),
                                         Lookout::Diff::Range.new('', 0...0)) << 1
  end

  expect Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('abc', 0..0),
                                              Lookout::Diff::Range.new('abc', 0..0)) do
    Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('abc', 0..2),
                                         Lookout::Diff::Range.new('abc', 0..2)) << 1
  end

  expect mock.to.receive.
    equal(Lookout::Diff::Operations::Equal.
            new(Lookout::Diff::Range.new('a', 0..0),
                Lookout::Diff::Range.new('a', 0..0))).once do |o|
    Lookout::Diff::Operations::Equal.new(Lookout::Diff::Range.new('a', 0..0),
                                         Lookout::Diff::Range.new('a', 0..0)).apply(o)
  end
end