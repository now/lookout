# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Equality.equal?(Lookout::Output.new('a').tap{ |io| io.write('a') }, nil)
  end

  expect false do
    Lookout::Equality.equal?(Lookout::Output.new('a').tap{ |io| io.write('b') }, nil)
  end

  expect '[-b-]{+a+}' do
    Lookout::Equality.diff(Lookout::Output.new('a').tap{ |io| io.write('b') }, nil)
  end

  expect 'output("b")≠output("a"): [-b-]{+a+}' do
    Lookout::Equality.message(Lookout::Output.new('a').tap{ |io| io.write('b') }, nil)
  end
end
