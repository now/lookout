# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect "fo[o|a], mismatch at index 2\nTrailing expected: < bar baz>\nTrailing actual: < bar bat>" do
    "foo bar baz".diff("foa bar bat")
  end
end
