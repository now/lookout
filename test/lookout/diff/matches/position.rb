# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Diff::Match.new(0, 0, 0) do
    Lookout::Diff::Matches::Position.origin('abc', 'xyz').match
  end

  expect Lookout::Diff::Match.new(0, 0, 3) do
    Lookout::Diff::Matches::Position.origin('abc', 'abc').match
  end

  expect Lookout::Diff::Match.new(1, 0, 3) do
    Lookout::Diff::Matches::Position.origin('Xabc', 'abc').match
  end

  expect Lookout::Diff::Match.new(0, 0, 3) do
    Lookout::Diff::Matches::Position.origin('abcX', 'abc').match
  end

  expect Lookout::Diff::Match.new(0, 1, 3) do
    Lookout::Diff::Matches::Position.origin('abc', 'Xabc').match
  end

  expect Lookout::Diff::Match.new(0, 0, 3) do
    Lookout::Diff::Matches::Position.origin('abc', 'abcX').match
  end

  expect Lookout::Diff::Match.new(0, 0, 2) do
    Lookout::Diff::Matches::Position.origin('ab', 'abXabc').match
  end

  expect Lookout::Diff::Match.new(0, 3, 3) do
    Lookout::Diff::Matches::Position.origin('abc', 'abXabc').match
  end

  expect Lookout::Diff::Match.new(1, 0, 3) do
    Lookout::Diff::Matches::Position.origin(' abc', 'abc abc'){ |c| c == ' '[0] }.match
  end

  # TODO: Need more tests for is_junk.

  expect false do
    Lookout::Diff::Matches::Position.origin('abc', 'abc').begins_before? Lookout::Diff::Match.new(0, 0, 1)
  end

  expect true do
    Lookout::Diff::Matches::Position.origin('abc', 'abc').begins_before? Lookout::Diff::Match.new(1, 1, 1)
  end

  expect false do
    Lookout::Diff::Matches::Position.origin('abc', 'abc').ends_after? Lookout::Diff::Match.new(3, 3, 1)
  end

  expect true do
    Lookout::Diff::Matches::Position.origin('abc', 'abc').ends_after? Lookout::Diff::Match.new(1, 1, 1)
  end

  expect Lookout::Diff::Matches::Position.new(Lookout::Diff::Matches::From.new('dabcX', 4...5),
                                              Lookout::Diff::Matches::To.new('ddabcY', 5...6),
                                              {}) do
    Lookout::Diff::Matches::Position.origin('dabcX', 'ddabcY').begin_at(Lookout::Diff::Match.new(1, 2, 3))
  end

  expect Lookout::Diff::Matches::Position.new(Lookout::Diff::Matches::From.new('abcdd', 0...1),
                                              Lookout::Diff::Matches::From.new('abcd', 0...2),
                                              {}) do
    Lookout::Diff::Matches::Position.origin('abcdd', 'abcd').end_at(Lookout::Diff::Match.new(1, 2, 3))
  end
end
