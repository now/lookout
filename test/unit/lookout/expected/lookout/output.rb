# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Lookout::Output do
    Lookout::Output.new('a').to_lookout_expected.expect('test', 1)
  end

  expect nil do
    Lookout::Output.new('a').to_lookout_expected.difference(Lookout::Output.new('a'))
  end

  expect Lookout::Difference::Lookout::Output do
    Lookout::Output.new('a').to_lookout_expected.difference(Lookout::Output.new('b'))
  end
end
