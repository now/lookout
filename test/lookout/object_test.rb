# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect true do
    object = Object.new
    Lookout::Literals.equalify(object) == object
  end

  expect false do
    Lookout::Literals.equalify(Object.new) == Object.new
  end
end
