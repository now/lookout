# -*- coding: utf-8 -*-

Expectations do
  expect 'warning("b")≉warning("a")' do
    Lookout::Difference::Lookout::Warning.new(Lookout::Warning.new('b'), Lookout::Warning.new('a')).message
  end

  expect '[-b-]{+a+}' do
    Lookout::Difference::Lookout::Warning.new(Lookout::Warning.new('b'), Lookout::Warning.new('a')).diff.to_s
  end
end
