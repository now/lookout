# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be positive: -1 < 1') do
    Lookout::Mock::Method::Calls::Upper.new(:object, :method, -1)
  end

  expect ArgumentError.new('limit must be positive: 0 < 1') do
    Lookout::Mock::Method::Calls::Upper.new(:object, :method, 0)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 1) do |o|
    o.call
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 1) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method twice, expected at most once') do
    Lookout::Mock::Method::Calls::Upper.new(:object, :method, 1).call.call
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 2) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 2) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 2) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 3 times, expected at most twice') do
    Lookout::Mock::Method::Calls::Upper.new(:object, :method, 2).call.call.call
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 3) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 3) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 3) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Upper.new(:object, :method, 3) do |o|
    o.call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object received #method 4 times, expected at most 3 times') do
    Lookout::Mock::Method::Calls::Upper.new(:object, :method, 3).call.call.call.call
  end
end
