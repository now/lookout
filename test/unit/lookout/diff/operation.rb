# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Diff::Operation.new(Lookout::Diff::Range.new('', 0...0),
                                 Lookout::Diff::Range.new('', 0...0)) ==
    Lookout::Diff::Operation.new(Lookout::Diff::Range.new('', 0...0),
                                 Lookout::Diff::Range.new('', 0...0))
  end

  expect false do
    Lookout::Diff::Operation.new(Lookout::Diff::Range.new('', 0...0),
                                 Lookout::Diff::Range.new('', 0...0)) ==
    Lookout::Diff::Operation.new(Lookout::Diff::Range.new('', 0...1),
                                 Lookout::Diff::Range.new('', 0...3))
  end
end
