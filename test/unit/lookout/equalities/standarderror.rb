# -*- coding: utf-8 -*-

Expectations do
  expect true do
    a = RuntimeError.new('a')
    Lookout::Equality.equal?(a, a)
  end

  expect true do
    Lookout::Equality.equal?(RuntimeError.new('a'), begin raise 'a'; rescue => e; e end)
  end

  expect false do
    Lookout::Equality.equal?(RuntimeError.new('a'), RuntimeError.new('b'))
  end

  expect false do
    Lookout::Equality.equal?(RuntimeError.new('a'), StandardError.new('a'))
  end
end
