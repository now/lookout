# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be positive: -1 < 1') do
    Lookout::Mock::Method::Calls::Lower.new(-1)
  end

  expect ArgumentError.new('limit must be positive: 0 < 1') do
    Lookout::Mock::Method::Calls::Lower.new(0)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(1) do |o|
    o.call
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at least once') do
    Lookout::Mock::Method::Calls::Lower.new(1).verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(1) do |o|
    o.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at least twice') do
    Lookout::Mock::Method::Calls::Lower.new(2).verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at least twice, but was only called once') do
    Lookout::Mock::Method::Calls::Lower.new(2).call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(2) do |o|
    o.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(2) do |o|
    o.call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at least 3 times') do
    Lookout::Mock::Method::Calls::Lower.new(3).verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at least 3 times, but was only called once') do
    Lookout::Mock::Method::Calls::Lower.new(3).call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at least 3 times, but was only called twice') do
    Lookout::Mock::Method::Calls::Lower.new(3).call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(3) do |o|
    o.call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(3) do |o|
    o.call.call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at least 4 times, but was only called 3 times') do
    Lookout::Mock::Method::Calls::Lower.new(4).call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(4) do |o|
    o.call.call.call.call.verify(:method)
  end
end
