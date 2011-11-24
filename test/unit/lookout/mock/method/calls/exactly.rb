# -*- coding: utf-8 -*-

Expectations do
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
end
