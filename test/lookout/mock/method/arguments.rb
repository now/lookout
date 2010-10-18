# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect true do
    Lookout::Mock::Method::Arguments.new.verify
  end

  expect true do
    Lookout::Mock::Method::Arguments.new.verify(4)
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::None).verify(4)
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method::Arguments.new(1, 2, 3).verify(4, 5, 6)
  end
end
