# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Mock::Method::Arguments.new.verify
  end

  expect true do
    Lookout::Mock::Method::Arguments.new.verify(1)
  end

  expect true do
    Lookout::Mock::Method::Arguments.new.verify(1, 2)
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::Anything.new).verify
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::Anything.new).verify(1)
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::Anything.new).verify(1, 2)
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::Anything.new,
                                         Lookout::Mock::Method::Arguments::Anything.new).verify(1)
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::Anything.new,
                                         Lookout::Mock::Method::Arguments::Anything.new).verify(1, 2)
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(1, 2, 3).verify(1, 2, 3)
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method::Arguments.new(1, 2, 3).verify(4, 5, 6)
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(/bcd/).verify('abcde')
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::None.new).verify
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::None.new).verify(4)
  end
end
