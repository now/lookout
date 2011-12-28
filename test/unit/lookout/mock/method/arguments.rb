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

  expect Lookout::Mock::Method::Arguments::Error.new('unexpected arguments: ()≠(Object)') do
    Lookout::Mock::Method::Arguments.new(Object).verify
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(Object).verify(1)
  end

  expect Lookout::Mock::Method::Arguments::Error.new('unexpected arguments: (1, 2)≠(Object)') do
    Lookout::Mock::Method::Arguments.new(Object).verify(1, 2)
  end

  expect Lookout::Mock::Method::Arguments::Error.new('unexpected arguments: (1)≠(Object, Object)') do
    Lookout::Mock::Method::Arguments.new(Object, Object).verify(1)
  end

  expect Lookout::Mock::Method::Arguments::Error.new('unexpected arguments: ((cannot inspect argument: error))≠(Object, Object)') do
    Lookout::Mock::Method::Arguments.new(Object, Object).verify(stub(:inspect => proc{ raise 'error' }))
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(Object, Object).verify(1, 2)
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(1, 2, 3).verify(1, 2, 3)
  end

  expect Lookout::Mock::Method::Arguments::Error.new('unexpected arguments: (4, 5, 6)≠(1, 2, 3)') do
    Lookout::Mock::Method::Arguments.new(1, 2, 3).verify(4, 5, 6)
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(/bcd/).verify('abcde')
  end

  expect true do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::None.new).verify
  end

  expect Lookout::Mock::Method::Arguments::Error.new('unexpected arguments: (4)≠()') do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::None.new).verify(4)
  end

  expect '' do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::None.new).inspect
  end

  expect '(1)' do
    Lookout::Mock::Method::Arguments.new(1).inspect
  end

  expect [Lookout::Mock::Method::Arguments::Any] do
    Lookout::Mock::Method::Arguments.new.to_a
  end

  expect [1, 2, 3] do
    Lookout::Mock::Method::Arguments.new(1, 2, 3).to_a
  end

  expect [Lookout::Mock::Method::Arguments::None] do
    Lookout::Mock::Method::Arguments.new(Lookout::Mock::Method::Arguments::None.new).to_a
  end
end
