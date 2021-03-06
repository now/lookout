# -*- coding: utf-8 -*-

Expectations do
  expect result.not.foldable?(0) do
    Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('', 0...0),
                                        Lookout::Diff::Slice.new('', 0...0))
  end

  expect result.not.foldable?(1) do
    Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('ab', 0..1),
                                        Lookout::Diff::Slice.new('ab', 0..1))
  end

  expect result.foldable?(1) do
    Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('abc', 0..2),
                                        Lookout::Diff::Slice.new('abc', 0..2))
  end

  expect Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('', 0...0),
                                              Lookout::Diff::Slice.new('', 0...0)) do
    Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('', 0...0),
                                        Lookout::Diff::Slice.new('', 0...0)) >> 1
  end

  expect Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('abc', 2..2),
                                              Lookout::Diff::Slice.new('abc', 2..2)) do
    Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('abc', 0..2),
                                        Lookout::Diff::Slice.new('abc', 0..2)) >> 1
  end

  expect Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('', 0...0),
                                              Lookout::Diff::Slice.new('', 0...0)) do
    Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('', 0...0),
                                        Lookout::Diff::Slice.new('', 0...0)) << 1
  end

  expect Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('abc', 0..0),
                                             Lookout::Diff::Slice.new('abc', 0..0)) do
    Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('abc', 0..2),
                                        Lookout::Diff::Slice.new('abc', 0..2)) << 1
  end

  expect mock.to.receive.
    copy(Lookout::Diff::Operations::Copy.
         new(Lookout::Diff::Slice.new('a', 0..0),
             Lookout::Diff::Slice.new('a', 0..0))).once do |o|
    Lookout::Diff::Operations::Copy.new(Lookout::Diff::Slice.new('a', 0..0),
                                        Lookout::Diff::Slice.new('a', 0..0)).apply(o)
  end
end
