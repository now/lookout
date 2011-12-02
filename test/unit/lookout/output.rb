# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Output.new('a') == Lookout::Output.new('a')
  end

  expect false do
    Lookout::Output.new('a') == Lookout::Output.new("a\n")
  end

  expect false do
    Lookout::Output.new('a') == Lookout::Output.new('b')
  end

  expect false do
    Lookout::Output.new('a') == Lookout::Output.new("b\n")
  end

  expect '[-b-]{+a+}' do
    Lookout::Output.new('a').diff(Lookout::Output.new('b'))
  end

  expect 'output("a")' do
    Lookout::Output.new('a').inspect
  end

  expect 'output("a")' do
    Lookout::Output.new('a').inspect
  end
end
