# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Equality.equal? Lookout::Output.new('a'), Lookout::Output.new('a')
  end

  expect false do
    Lookout::Equality.equal? Lookout::Output.new('a'), Lookout::Output.new('b')
  end

  expect '[-b-]{+a+}' do
    Lookout::Equality.diff(Lookout::Output.new('a'), Lookout::Output.new('b'))
  end

  expect 'output("b")≠output("a"): [-b-]{+a+}' do
    Lookout::Equality.message(Lookout::Output.new('a'), Lookout::Output.new('b'))
  end
end
