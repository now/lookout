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

  expect Lookout::Mock::Method::Calls::Error.new(':object #method receipts: 0<1') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 1).verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 1) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object #method receipts: 0<2') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 2).verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object #method receipts: 1<2') do
    Lookout::Mock::Method::Calls::Lower.new(:object, :method, 2).call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 2) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Lower.new(:object, :method, 2) do |o|
    o.call.call.call.verify
  end
end
