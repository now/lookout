# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Array do
    %w[abc].to_lookout_expected.difference(nil)
  end

  expect Lookout::Difference::Array do
    %w[abc].to_lookout_expected.difference([])
  end

  expect nil do
    %w[abc].to_lookout_expected.difference(%w[abc])
  end

  expect nil do
    [Integer].to_lookout_expected.difference([1])
  end
end
