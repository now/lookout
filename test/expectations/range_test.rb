# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do
  expect true do
    (1..5).expectations_equal_to 3
  end

  expect true do
    (1..5).expectations_equal_to 1..5
  end

  expect false do
    (1..5).expectations_equal_to 6
  end
end
