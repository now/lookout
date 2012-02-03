# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Lookout::Output do
    Lookout::Output.new('a').to_lookout_expected.expect('test', 1)
  end

  expect true do
    Lookout::Output.new('a').to_lookout_expected =~ Lookout::Output.new('a')
  end

  expect false do
    Lookout::Output.new('a').to_lookout_expected =~ Lookout::Output.new('b')
  end
end
