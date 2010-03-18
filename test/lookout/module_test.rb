# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect true do
    Lookout::Literals.equalify(String) == 'foo'
  end

  expect true do
    Lookout::Literals.equalify(String) == String
  end

  expect false do
    Lookout::Literals.equalify(String) == 0
  end
end
