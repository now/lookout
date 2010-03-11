# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do
  expect "fo[o|a], mismatch at index 2\nTrailing expected: < bar baz>\nTrailing actual: < bar bat>" do
    "foo bar baz".diff("foa bar bat")
  end
end
