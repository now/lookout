# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Output.new('a').to_lookout_expected =~ Lookout::Output.new('a')
  end

  expect false do
    Lookout::Output.new('a').to_lookout_expected =~ Lookout::Output.new('b')
  end

  expect '[-b-]{+a+}' do
    Lookout::Output.new('a').to_lookout_expected.diff(Lookout::Output.new('b'))
  end

  expect 'output("b")≠output("a"): [-b-]{+a+}' do
    Lookout::Output.new('a').to_lookout_expected.message(Lookout::Output.new('b'))
  end
end
