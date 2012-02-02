# -*- coding: utf-8 -*-

Expectations do
  expect false do
    %w[abc].to_lookout_expected =~ nil
  end

  expect false do
    %w[abc].to_lookout_expected =~ []
  end

  expect true do
    %w[abc].to_lookout_expected =~ %w[abc]
  end

  expect true do
    [Integer].to_lookout_expected =~ [1]
  end
end
