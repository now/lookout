# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be non-negative: -1 < 0') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, -1)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:method, 0) do |o|
    o.call
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:method, 0) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method not to be called') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 0).call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method not to be called, but was called twice') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 0).call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method not to be called, but was called 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 0).call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 1).verify
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:method, 1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called once, not twice') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 1).call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called once, not 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 1).call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called twice') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 2).verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called twice, but was only called once') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 2).call.verify
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:method, 2) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called twice, not 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 2).call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called 3 times') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 3).verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called 3 times, but was only called once') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 3).call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called 3 times, but was only called twice') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 3).call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:method, 3) do |o|
    o.call.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected method to be called 3 times, not 4 times') do
    Lookout::Mock::Method::Calls::Exactly.new(:method, 3).call.call.call.call.verify
  end
end
