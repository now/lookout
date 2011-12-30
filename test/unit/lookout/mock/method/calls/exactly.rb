# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('limit must be non-negative: -1 < 0') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, -1)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 0) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object #method receipts: 1≠0') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 0).call
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object #method receipts: 0≠1') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1).verify
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new(':object #method receipts: 2≠1') do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1).call.call
  end
end
