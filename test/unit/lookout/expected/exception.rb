# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Exception do
    RuntimeError.new('a').to_lookout_expected.expect('test', 1)
  end

  expect nil do
    a = RuntimeError.new('a')
    a.to_lookout_expected.difference(a)
  end

  expect nil do
    RuntimeError.new('a').to_lookout_expected.difference(begin raise 'a'; rescue => e; e end)
  end

  expect Lookout::Difference::Exception do
    RuntimeError.new('a').to_lookout_expected.difference(RuntimeError.new('b'))
  end

  expect Lookout::Difference::Exception do
    RuntimeError.new('a').to_lookout_expected.difference(StandardError.new('a'))
  end
end
