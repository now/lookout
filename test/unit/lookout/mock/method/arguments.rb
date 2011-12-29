# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Mock::Method::Arguments.new(:object, :method).verify
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(:object, :method).verify(1)
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(:object, :method).verify(1, 2)
  end

  expect Lookout::Mock::Method::Arguments::Error.new(':object received #method(), expected #method(Object)') do
    Lookout::Mock::Method::Arguments.new(:object, :method, Object).verify
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(:object, :method, Object).verify(1)
  end

  expect Lookout::Mock::Method::Arguments::Error.new(':object received #method(1, 2), expected #method(Object)') do
    Lookout::Mock::Method::Arguments.new(:object, :method, Object).verify(1, 2)
  end

  expect Lookout::Mock::Method::Arguments::Error.new(':object received #method(1), expected #method(Object, Object)') do
    Lookout::Mock::Method::Arguments.new(:object, :method, Object, Object).verify(1)
  end

  expect Lookout::Mock::Method::Arguments::Error.
    new(':object received #method((cannot inspect argument: error)), expected #method(Object, Object)') do
    Lookout::Mock::Method::Arguments.new(:object, :method, Object, Object).verify(stub(:inspect => proc{ raise 'error' }))
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(:object, :method, Object, Object).verify(1, 2)
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(:object, :method, 1, 2, 3).verify(1, 2, 3)
  end

  expect Lookout::Mock::Method::Arguments::Error.new(':object received #method(4, 5, 6), expected #method(1, 2, 3)') do
    Lookout::Mock::Method::Arguments.new(:object, :method, 1, 2, 3).verify(4, 5, 6)
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(:object, :method, /bcd/).verify('abcde')
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(:object, :method, Lookout::Mock::Method::Arguments::None.new).verify
  end

  expect Lookout::Mock::Method::Arguments::Error.new(':object received #method(4), expected #method()') do
    Lookout::Mock::Method::Arguments.new(:object, :method, Lookout::Mock::Method::Arguments::None.new).verify(4)
  end

  expect '' do
    Lookout::Mock::Method::Arguments.new(:object, :method, Lookout::Mock::Method::Arguments::None.new).inspect
  end

  expect '(1)' do
    Lookout::Mock::Method::Arguments.new(:object, :method, 1).inspect
  end

  expect [Lookout::Mock::Method::Arguments::Any] do
    Lookout::Mock::Method::Arguments.new(:object, :method).to_a
  end

  expect [1, 2, 3] do
    Lookout::Mock::Method::Arguments.new(:object, :method, 1, 2, 3).to_a
  end

  expect [Lookout::Mock::Method::Arguments::None] do
    Lookout::Mock::Method::Arguments.new(:object, :method, Lookout::Mock::Method::Arguments::None.new).to_a
  end
end
