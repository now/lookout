# -*- coding: utf-8 -*-

Expectations do
  expect 'output("b")≠output("a")' do
    Lookout::Difference::Lookout::Output.new(Lookout::Output.new('b'), Lookout::Output.new('a')).message
  end

  expect '[-b-]{+a+}' do
    Lookout::Difference::Lookout::Output.new(Lookout::Output.new('b'), Lookout::Output.new('a')).diff.to_s
  end
end
