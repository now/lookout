# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect true do
    Lookout::Literals.equalify(1..5) == 3
  end

  expect true do
    Lookout::Literals.equalify(1..5) == (1..5)
  end

  expect false do
    Lookout::Literals.equalify(1..5) == 6
  end
end
