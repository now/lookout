# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Warning do
    Lookout::Warning.new('a').to_lookout_expected.actualize('test', 1)
  end

  expect true do
    Lookout::Warning.new('a').to_lookout_expected =~ Lookout::Warning.new('a')
  end

  expect false do
    Lookout::Warning.new('a').to_lookout_expected =~ Lookout::Warning.new('b')
  end

  expect true do
    Lookout::Warning.new('a').to_lookout_expected =~ Lookout::Warning.new('/a/b/c:1: warning: a')
  end
end
