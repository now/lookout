# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be non-negative: -1 < 0') do
    Lookout::Mock::Method::Calls::Exactly.new(-1)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(0) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('1≠0') do
    Lookout::Mock::Method::Calls::Exactly.new(0).call
  end

  expect Lookout::Mock::Method::Calls::Error.new('0≠1') do
    Lookout::Mock::Method::Calls::Exactly.new(1).verify
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('2≠1') do
    Lookout::Mock::Method::Calls::Exactly.new(1).call.call
  end
end
