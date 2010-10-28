# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect false do
    Lookout::Diff::Operations::Insert.new(0...0, 0...0).foldable? 0
  end

  expect false do
    Lookout::Diff::Operations::Insert.new(0...2, 0...2).foldable? 1
  end

  expect Lookout::Diff::Operations::Insert.new(0...0, 0...0) do
    Lookout::Diff::Operations::Insert.new(0...0, 0...0) >> 1
  end

  expect Lookout::Diff::Operations::Insert.new(0...2, 0...2) do
    Lookout::Diff::Operations::Insert.new(0...2, 0...2) >> 1
  end

  expect Lookout::Diff::Operations::Insert.new(0...0, 0...0) do
    Lookout::Diff::Operations::Insert.new(0...0, 0...0) << 1
  end

  expect Lookout::Diff::Operations::Insert.new(0...2, 0...2) do
    Lookout::Diff::Operations::Insert.new(0...2, 0...2) << 1
  end

  expect mock.to.receive.insert(Lookout::Diff::Operations::Insert.new(0...1, 0...1)).once do |o|
    Lookout::Diff::Operations::Insert.new(0...1, 0...1).apply(o)
  end
end
