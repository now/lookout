# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do
  expect true do
    String.expectations_equal_to "foo"
  end

  expect false do
    String.expectations_equal_to 0
  end

  expect true do
    String.expectations_equal_to String
  end
end
