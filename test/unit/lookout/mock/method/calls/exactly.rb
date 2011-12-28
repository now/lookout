# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be non-negative: -1 < 0') do
    Lookout::Mock::Method::Calls::Exactly.new(-1)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(0) do |o|
    o.call
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(0) do |o|
    o.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method not to be called') do
    Lookout::Mock::Method::Calls::Exactly.new(0).call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method not to be called, but was called twice') do
    Lookout::Mock::Method::Calls::Exactly.new(0).call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method not to be called, but was called 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(0).call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called') do
    Lookout::Mock::Method::Calls::Exactly.new(1).verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(1) do |o|
    o.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called once, not twice') do
    Lookout::Mock::Method::Calls::Exactly.new(1).call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called once, not 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(1).call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called twice') do
    Lookout::Mock::Method::Calls::Exactly.new(2).verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called twice, but was only called once') do
    Lookout::Mock::Method::Calls::Exactly.new(2).call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(2) do |o|
    o.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called twice, not 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(2).call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(3).verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called 3 times, but was only called once') do
    Lookout::Mock::Method::Calls::Exactly.new(3).call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called 3 times, but was only called twice') do
    Lookout::Mock::Method::Calls::Exactly.new(3).call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(3) do |o|
    o.call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called 3 times, not 4 times') do
    Lookout::Mock::Method::Calls::Exactly.new(3).call.call.call.call.verify(:method)
  end
end
