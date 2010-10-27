# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect true do
    Lookout::Diff::Operations::Equal.new(0...0, 0...0).adjustable?
  end

  expect Lookout::Diff::Operations::Equal.new(0...0, 0...0) do
    Lookout::Diff::Operations::Equal.new(0...0, 0...0) >> 1
  end

  expect Lookout::Diff::Operations::Equal.new(1...2, 1...2) do
    Lookout::Diff::Operations::Equal.new(0...2, 0...2) >> 1
  end

  expect Lookout::Diff::Operations::Equal.new(0...0, 0...0) do
    Lookout::Diff::Operations::Equal.new(0...0, 0...0) << 1
  end

  expect Lookout::Diff::Operations::Equal.new(0...1, 0...1) do
    Lookout::Diff::Operations::Equal.new(0...2, 0...2) << 1
  end
end