# -*- coding: utf-8 -*-

Expectations do
  expect literal(/a/) do
    /a/
  end

  expect true do
    Lookout::Literal.new(/a/).to_lookout_expected =~ /a/
  end

  expect false do
    Lookout::Literal.new(/a/).to_lookout_expected =~ 'a'
  end
end
