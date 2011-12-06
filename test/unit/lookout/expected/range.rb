# -*- coding: utf-8 -*-

Expectations do
  expect true do
    (1..5).to_lookout_expected =~ 3
  end

  expect false do
    (1..5).to_lookout_expected =~ 6
  end

  expect true do
    (1..5).to_lookout_expected =~ (1..5)
  end

  expect false do
    (1..5).to_lookout_expected =~ 'a'
  end
end
