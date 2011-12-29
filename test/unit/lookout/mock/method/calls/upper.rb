# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be positive: -1 < 1') do
    Lookout::Mock::Method::Calls::Upper.new(-1)
  end

  expect ArgumentError.new('limit must be positive: 0 < 1') do
    Lookout::Mock::Method::Calls::Upper.new(0)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(1) do |o|
    o.call
  end

  expect Lookout::Mock::Method::Calls::Upper.new(1) do |o|
    o.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(1) do |o|
    o.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method twice, expected at most once') do
    Lookout::Mock::Method::Calls::Upper.new(1).call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 3 times, expected at most once') do
    Lookout::Mock::Method::Calls::Upper.new(1).call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(2) do |o|
    o.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(2) do |o|
    o.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(2) do |o|
    o.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 3 times, expected at most twice') do
    Lookout::Mock::Method::Calls::Upper.new(2).call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(3) do |o|
    o.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(3) do |o|
    o.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(3) do |o|
    o.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(3) do |o|
    o.call.call.call.verify(:object, :method)
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 4 times, expected at most 3 times') do
    Lookout::Mock::Method::Calls::Upper.new(3).call.call.call.call.verify(:object, :method)
  end
end
