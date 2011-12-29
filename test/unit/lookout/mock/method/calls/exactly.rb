# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be non-negative: -1 < 0') do
    Lookout::Mock::Method::Calls::Exactly.new(-1)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(0) do |o|
    o.call
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(0) do |o|
    o.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received unexpected #method') do
    Lookout::Mock::Method::Calls::Exactly.new(0).call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received unexpected #method twice') do
    Lookout::Mock::Method::Calls::Exactly.new(0).call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received unexpected #method 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(0).call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method') do
    Lookout::Mock::Method::Calls::Exactly.new(1).verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(1) do |o|
    o.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method twice, expected once') do
    Lookout::Mock::Method::Calls::Exactly.new(1).call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 3 times, expected once') do
    Lookout::Mock::Method::Calls::Exactly.new(1).call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected twice') do
    Lookout::Mock::Method::Calls::Exactly.new(2).verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method once, expected twice') do
    Lookout::Mock::Method::Calls::Exactly.new(2).call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(2) do |o|
    o.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 3 times, expected twice') do
    Lookout::Mock::Method::Calls::Exactly.new(2).call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(3).verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method once, expected 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(3).call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method twice, expected 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(3).call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(3) do |o|
    o.call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 4 times, expected 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(3).call.call.call.call.verify(:object, :method)
  end
end
