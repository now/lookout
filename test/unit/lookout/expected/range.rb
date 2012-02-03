# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    (1..5).to_lookout_expected.difference(3)
  end

  expect Lookout::Difference::Range do
    (1..5).to_lookout_expected.difference(6)
  end

  expect nil do
    (1..5).to_lookout_expected.difference((1..5))
  end

  expect Lookout::Difference::Range do
    (1..5).to_lookout_expected.difference('a')
  end
end
