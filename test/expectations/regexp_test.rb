# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do
  expect true do
    /foo/.expectations_equal_to "foo"
  end

  expect true do
    /foo/.expectations_equal_to /foo/
  end

  expect false do
    /foo/.expectations_equal_to /bar/
  end
end
