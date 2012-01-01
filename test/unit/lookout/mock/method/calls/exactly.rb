# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('expected mock method invocation count must be non-negative: -1 < 0') do
    Lookout::Mock::Method::Calls::Exactly.new(-1)
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(0) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::TooManyError.new('unexpected number of invocations (1 for 0)') do
    Lookout::Mock::Method::Calls::Exactly.new(0).call
  end

  expect Lookout::Mock::Method::Calls::TooFewError.new('unexpected number of invocations (0 for 1)') do
    Lookout::Mock::Method::Calls::Exactly.new(1).verify
  end

  expect Lookout::Mock::Method::Calls::Exactly.new(1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::TooManyError.new('unexpected number of invocations (2 for 1)') do
    Lookout::Mock::Method::Calls::Exactly.new(1).call.call
  end
end
