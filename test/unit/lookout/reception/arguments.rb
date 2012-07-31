# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Reception::Arguments.new.verify
  end

  expect true do
    Lookout::Reception::Arguments.new.verify(1)
  end

  expect true do
    Lookout::Reception::Arguments.new.verify(1, 2)
  end

  expect Lookout::Reception::Arguments::Error.new('unexpected arguments ([]≠[Object])') do
    Lookout::Reception::Arguments.new(Object).verify
  end

  expect true do
    Lookout::Reception::Arguments.new(Object).verify(1)
  end

  expect Lookout::Reception::Arguments::Error.new('unexpected arguments ([1, 2]≠[Object])') do
    Lookout::Reception::Arguments.new(Object).verify(1, 2)
  end

  expect Lookout::Reception::Arguments::Error.new('unexpected arguments ([1]≠[Object, Object])') do
    Lookout::Reception::Arguments.new(Object, Object).verify(1)
  end

  expect Lookout::Reception::Arguments::Error.
    new('unexpected arguments ([(cannot inspect argument: error)]≠[Object, Object])') do
    Lookout::Reception::Arguments.new(Object, Object).verify(stub(:inspect => proc{ raise 'error' }))
  end

  expect true do
    Lookout::Reception::Arguments.new(Object, Object).verify(1, 2)
  end

  expect true do
    Lookout::Reception::Arguments.new(1, 2, 3).verify(1, 2, 3)
  end

  expect Lookout::Reception::Arguments::Error.new('unexpected arguments ([4, 5, 6]≠[1, 2, 3])') do
    Lookout::Reception::Arguments.new(1, 2, 3).verify(4, 5, 6)
  end

  expect true do
    Lookout::Reception::Arguments.new(/bcd/).verify('abcde')
  end

  expect true do
    Lookout::Reception::Arguments.new(Lookout::Reception::Arguments::None.new).verify
  end

  expect Lookout::Reception::Arguments::Error.new('unexpected arguments ([4]≠[])') do
    Lookout::Reception::Arguments.new(Lookout::Reception::Arguments::None.new).verify(4)
  end

  expect '' do
    Lookout::Reception::Arguments.new(Lookout::Reception::Arguments::None.new).to_s
  end

  expect '(1)' do
    Lookout::Reception::Arguments.new(1).to_s
  end

  expect [Lookout::Reception::Arguments::Any] do
    Lookout::Reception::Arguments.new.to_a
  end

  expect [1, 2, 3] do
    Lookout::Reception::Arguments.new(1, 2, 3).to_a
  end

  expect [Lookout::Reception::Arguments::None] do
    Lookout::Reception::Arguments.new(Lookout::Reception::Arguments::None.new).to_a
  end
end
