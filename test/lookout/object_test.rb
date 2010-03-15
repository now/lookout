# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect true do
    object = Object.new
    object.expectations_equal_to object
  end

  expect false do
    Object.new.expectations_equal_to Object.new
  end
end
