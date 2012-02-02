# -*- coding: utf-8 -*-

Expectations do
  expect NoMethodError.
    new("cannot convert upper mock method invocation limit to Integer: undefined method `to_int' for nil:NilClass") do
    Object.new.to.receive.a.at_most(nil)
  end

  expect ArgumentError.new('upper mock method invocation limit must be positive: -1 < 1') do
    Object.new.to.receive.a.at_most(-1)
  end

  expect ArgumentError.new('upper mock method invocation limit must be positive: 0 < 1') do
    Object.new.to.receive.a.at_most(0)
  end

  expect Lookout::Reception do
    Object.new.to.receive.a.at_most(1)
  end

  expect ArgumentError.new('expected mock method invocation count must be non-negative: -1 < 0') do
    Object.new.to.receive.a.exactly(-1)
  end

  expect Lookout::Reception do
    Object.new.to.receive.a.exactly(0)
  end

  expect ArgumentError.new('lower mock method invocation limit must be positive: -1 < 1') do
    Object.new.to.receive.a.at_least(-1)
  end

  expect ArgumentError.new('lower mock method invocation limit must be positive: 0 < 1') do
    Object.new.to.receive.a.at_least(0)
  end

  expect Lookout::Reception do
    Object.new.to.receive.a.at_least(1)
  end
end
