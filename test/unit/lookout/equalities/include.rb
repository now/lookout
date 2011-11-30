# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Equality.equal? String, 'a'
  end

  expect false do
    Lookout::Equality.equal? String, 1
  end

  expect true do
    Lookout::Equality.equal? String, String
  end

  expect false do
    Lookout::Equality.equal? String, Integer
  end

  expect true do
    Lookout::Equality.equal? Module, String
  end

  expect true do
    Lookout::Equality.equal? 1..5, 3
  end

  expect false do
    Lookout::Equality.equal? 1..5, 6
  end

  expect true do
    Lookout::Equality.equal? 1..5, (1..5)
  end

  expect false do
    Lookout::Equality.equal? 1..5, 'a'
  end

  expect true do
    Lookout::Equality.equal?(/a/, 'a')
  end

  expect true do
    Lookout::Equality.equal?(/a/, /a/)
  end

  expect false do
    Lookout::Equality.equal?(/a/, 'b')
  end

  expect false do
    Lookout::Equality.equal?(/a/, /b/)
  end

  expect true do
    Lookout::Equality.equal?(Lookout::Warning.new('a'),
                             Lookout::Warning.new('a'))
  end

  expect false do
    Lookout::Equality.equal?(Lookout::Warning.new('a'),
                             Lookout::Warning.new('b'))
  end

  expect true do
    Lookout::Equality.equal?(Lookout::Warning.new('a'),
                             Lookout::Warning.new('/a/b/c:1: warning: a'))
  end
end
