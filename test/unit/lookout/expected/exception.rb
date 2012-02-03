# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Exception do
    RuntimeError.new('a').to_lookout_expected.expect('test', 1)
  end

  expect true do
    a = RuntimeError.new('a')
    a.to_lookout_expected =~ a
  end

  expect true do
    RuntimeError.new('a').to_lookout_expected =~ (begin raise 'a'; rescue => e; e end)
  end

  expect false do
    RuntimeError.new('a').to_lookout_expected =~ RuntimeError.new('b')
  end

  expect false do
    RuntimeError.new('a').to_lookout_expected =~ StandardError.new('a')
  end
end
