# -*- coding: utf-8 -*-

Expectations do
  expect true do
    String.to_lookout_expected =~ 'a'
  end

  expect false do
    String.to_lookout_expected =~ 1
  end

  expect true do
    String.to_lookout_expected =~ String
  end

  expect false do
    String.to_lookout_expected =~ Integer
  end

  expect true do
    Module.to_lookout_expected =~ String
  end
end
