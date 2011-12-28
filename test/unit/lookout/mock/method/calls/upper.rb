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
    o.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(1) do |o|
    o.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at most once, but was called twice') do
    Lookout::Mock::Method::Calls::Upper.new(1).call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at most once, but was called 3 times') do
    Lookout::Mock::Method::Calls::Upper.new(1).call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(2) do |o|
    o.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(2) do |o|
    o.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(2) do |o|
    o.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at most twice, but was called 3 times') do
    Lookout::Mock::Method::Calls::Upper.new(2).call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(3) do |o|
    o.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(3) do |o|
    o.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(3) do |o|
    o.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Upper.new(3) do |o|
    o.call.call.call.verify(:method)
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called at most 3 times, but was called 4 times') do
    Lookout::Mock::Method::Calls::Upper.new(3).call.call.call.call.verify(:method)
  end
end
