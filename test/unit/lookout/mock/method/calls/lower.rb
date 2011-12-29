# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be positive: -1 < 1') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, -1)
  end

  expect ArgumentError.new('limit must be positive: 0 < 1') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 0)
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 1) do |o|
    o.call
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected at least once') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 1).verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected at least twice') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 2).verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method once, expected at least twice') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 2).call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 2) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 2) do |o|
    o.call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected at least 3 times') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 3).verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method once, expected at least 3 times') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 3).call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method twice, expected at least 3 times') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 3).call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 3) do |o|
    o.call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 3) do |o|
    o.call.call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 3 times, expected at least 4 times') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 4).call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 4) do |o|
    o.call.call.call.call.verify
  end
end
