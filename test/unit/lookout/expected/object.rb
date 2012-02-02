# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Object do
    Object.new.to_lookout_expected.actualize('test', 1)
  end

  expect true do
    object = Object.new
    object.to_lookout_expected =~ object
  end

  expect true do
    1.to_lookout_expected =~ 1
  end

  expect false do
    Object.new.to_lookout_expected =~ Object.new
  end

  expect false do
    1.to_lookout_expected =~ 2
  end
end
