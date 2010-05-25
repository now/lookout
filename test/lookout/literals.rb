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

  expect true do
    object = Object.new
    Lookout::Literals.equalify(object) == object
  end

  expect false do
    Lookout::Literals.equalify(Object.new) == Object.new
  end

  expect true do
    Lookout::Literals.equalify(1..5) == 3
  end

  expect true do
    Lookout::Literals.equalify(1..5) == (1..5)
  end

  expect false do
    Lookout::Literals.equalify(1..5) == 6
  end

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

  expect false do
    Lookout::Literals.equalify(Module).eql? RuntimeError
  end

  expect false do
    Lookout::Literals.equalify(true).eql? RuntimeError
  end
end
