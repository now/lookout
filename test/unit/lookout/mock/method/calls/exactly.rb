# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be non-negative: -1 < 0') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, -1)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 0) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method unexpectedly') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 0).call
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1).verify
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method twice, expected once') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1).call.call
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected twice') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 2).verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method once, expected twice') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 2).call.verify
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 2) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 3 times, expected twice') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 2).call.call.call
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object didn’t receive #method, expected 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 3).verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method once, expected 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 3).call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method twice, expected 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 3).call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 3) do |o|
    o.call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 4 times, expected 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 3).call.call.call.call
  end
end
