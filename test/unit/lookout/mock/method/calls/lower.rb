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

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected at least once') do
    Lookout::Mock::Method::Calls::Lower.new(1).verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(1) do |o|
    o.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected at least twice') do
    Lookout::Mock::Method::Calls::Lower.new(2).verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method once, expected at least twice') do
    Lookout::Mock::Method::Calls::Lower.new(2).call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(2) do |o|
    o.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(2) do |o|
    o.call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected at least 3 times') do
    Lookout::Mock::Method::Calls::Lower.new(3).verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method once, expected at least 3 times') do
    Lookout::Mock::Method::Calls::Lower.new(3).call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method twice, expected at least 3 times') do
    Lookout::Mock::Method::Calls::Lower.new(3).call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(3) do |o|
    o.call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(3) do |o|
    o.call.call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 3 times, expected at least 4 times') do
    Lookout::Mock::Method::Calls::Lower.new(4).call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(4) do |o|
    o.call.call.call.call.verify(:object, :method)
  end
end
