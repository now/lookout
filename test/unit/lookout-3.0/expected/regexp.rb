# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    /a/.to_lookout_expected.difference('a')
  end

  expect nil do
    /a/.to_lookout_expected.difference(/a/)
  end

  expect Lookout::Difference::Regexp do
    /a/.to_lookout_expected.difference('b')
  end

  expect Lookout::Difference::Regexp do
    /a/.to_lookout_expected.difference(/b/)
  end
end
