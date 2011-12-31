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

  expect Lookout::Mock::Method::Calls::TooFewError.new('unexpected number of invocations (0 for 1..)') do
    Lookout::Mock::Method::Calls::Lower.new(1).verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(1) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::TooFewError.new('unexpected number of invocations (0 for 2..)') do
    Lookout::Mock::Method::Calls::Lower.new(2).verify
  end

  expect Lookout::Mock::Method::Calls::TooFewError.new('unexpected number of invocations (1 for 2..)') do
    Lookout::Mock::Method::Calls::Lower.new(2).call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(2) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(2) do |o|
    o.call.call.call.verify
  end
end
