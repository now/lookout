# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Diff::Match.new(Lookout::Diff::Range.new('abc', 0...0),
                                  Lookout::Diff::Range.new('xyz', 0...0)) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abc', 'xyz').match
  end

  expect Lookout::Diff::Match.new(Lookout::Diff::Range.new('abc'),
                                  Lookout::Diff::Range.new('abc')) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abc', 'abc').match
  end

  expect Lookout::Diff::Match.new(Lookout::Diff::Range.new('Xabc', 1..3),
                                  Lookout::Diff::Range.new('abc')) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('Xabc', 'abc').match
  end

  expect Lookout::Diff::Match.new(Lookout::Diff::Range.new('abcX', 0..2),
                                  Lookout::Diff::Range.new('abc')) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abcX', 'abc').match
  end

  expect Lookout::Diff::Match.new(Lookout::Diff::Range.new('abc'),
                                  Lookout::Diff::Range.new('Xabc', 1..3)) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abc', 'Xabc').match
  end

  expect Lookout::Diff::Match.new(Lookout::Diff::Range.new('abc'),
                                  Lookout::Diff::Range.new('abcX', 0..2)) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abc', 'abcX').match
  end

  expect Lookout::Diff::Match.new(Lookout::Diff::Range.new('ab', 0..1),
                                  Lookout::Diff::Range.new('abXabc', 0..1)) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('ab', 'abXabc').match
  end

  expect Lookout::Diff::Match.new(Lookout::Diff::Range.new('abc'),
                                  Lookout::Diff::Range.new('abXabc', 3..5)) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abc', 'abXabc').match
  end

  expect Lookout::Diff::Match.new(Lookout::Diff::Range.new(' abc', 1..3),
                                  Lookout::Diff::Range.new('abc abc', 0..2)) do
    Lookout::Diff::Algorithms::Difflib::Position.origin(' abc', 'abc abc'){ |c| c == ' '[0] }.match
  end

  # TODO: Need more tests for is_junk.

  expect false do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abc', 'abc').
      begin_before? Lookout::Diff::Match.new(Lookout::Diff::Range.new('abc', 0..0),
                                             Lookout::Diff::Range.new('abc', 0..0))
  end

  expect true do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abc', 'abc').
      begin_before? Lookout::Diff::Match.new(Lookout::Diff::Range.new('abc', 1..1),
                                             Lookout::Diff::Range.new('abc', 1..1))
  end

  expect false do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abc', 'abc').
      end_after? Lookout::Diff::Match.new(Lookout::Diff::Range.new('abc', 3..3),
                                          Lookout::Diff::Range.new('abc', 3..3))
  end

  expect true do
    Lookout::Diff::Algorithms::Difflib::Position.origin('abc', 'abc').
      end_after? Lookout::Diff::Match.new(Lookout::Diff::Range.new('abc', 1..1),
                                          Lookout::Diff::Range.new('abc', 1..1))
  end

  expect Lookout::Diff::Algorithms::Difflib::Position.
           new(Lookout::Diff::Range.new('dabcX', 4..4),
               Lookout::Diff::Algorithms::Difflib::Position::To.new('ddabcY', 5..5),
               {}) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('dabcX', 'ddabcY').
      begin_after(Lookout::Diff::Match.new(Lookout::Diff::Range.new('dabcX', 0..3),
                                           Lookout::Diff::Range.new('ddabcY', 1..4)))
  end

  expect Lookout::Diff::Algorithms::Difflib::Position.
           new(Lookout::Diff::Range.new('dabcX', 0...0),
               Lookout::Diff::Algorithms::Difflib::Position::To.new('ddabcY', 0..0),
               {}) do
    Lookout::Diff::Algorithms::Difflib::Position.origin('dabcX', 'ddabcY').
      end_before(Lookout::Diff::Match.new(Lookout::Diff::Range.new('dabcX', 0..3),
                                          Lookout::Diff::Range.new('ddabcY', 1..4)))
  end
end
