# -*- coding: utf-8 -*-

Expectations do
  expect literal(/a/) do
    /a/
  end

  expect nil do
    Lookout::Literal.new(/a/).to_lookout_expected.difference(/a/)
  end

  expect Lookout::Difference::Object do
    Lookout::Literal.new(/a/).to_lookout_expected.difference('a')
  end
end
