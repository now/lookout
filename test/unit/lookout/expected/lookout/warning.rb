# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Lookout::Warning do
    Lookout::Warning.new('a').to_lookout_expected.expect('test', 1)
  end

  expect nil do
    Lookout::Warning.new('a').to_lookout_expected.difference(Lookout::Warning.new('a'))
  end

  expect Lookout::Difference::Lookout::Warning do
    Lookout::Warning.new('a').to_lookout_expected.difference(Lookout::Warning.new('b'))
  end

  expect nil do
    Lookout::Warning.new('a').to_lookout_expected.difference(Lookout::Warning.new('/a/b/c:1: warning: a'))
  end
end
