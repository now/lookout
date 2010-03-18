# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect true do
    Lookout::Literals.equalify(/foo/) == 'foo'
  end

  expect true do
    Lookout::Literals.equalify(/foo/) == /foo/
  end

  expect false do
    Lookout::Literals.equalify(/foo/) == 'bar'
  end

  expect false do
    Lookout::Literals.equalify(/foo/) == /bar/
  end
end
