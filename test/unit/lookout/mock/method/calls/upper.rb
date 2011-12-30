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
    o.verify
  end

  expect Lookout::Mock::Method::Calls::Upper.new(1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('2>1') do
    Lookout::Mock::Method::Calls::Upper.new(1).call.call
  end

  expect Lookout::Mock::Method::Calls::Upper.new(2) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::Upper.new(2) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Upper.new(2) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('3>2') do
    Lookout::Mock::Method::Calls::Upper.new(2).call.call.call
  end
end
