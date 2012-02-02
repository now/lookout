# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Mock::Method::Calls.new(1..1) ==
      Lookout::Mock::Method::Calls.new(1..1)
  end

  expect false do
    Lookout::Mock::Method::Calls.new(1..1) ==
      Lookout::Mock::Method::Calls.new(1..1).call
  end

  expect Lookout::Mock::Method::Calls.new(0..1) do |o|
    o.call
  end

  expect Lookout::Mock::Method::Calls.new(0..1) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls.new(0..1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::TooManyError.new('unexpected number of invocations (2 for 0..1)') do
    Lookout::Mock::Method::Calls.new(0..1).call.call
  end

  expect Lookout::Mock::Method::Calls.new(0..2) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls.new(0..2) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls.new(0..2) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::TooManyError.new('unexpected number of invocations (3 for 0..2)') do
    Lookout::Mock::Method::Calls.new(0..2).call.call.call
  end

  expect Lookout::Mock::Method::Calls.new(0..0) do |o|
    o.verify
  end

  expect Lookout::Mock::Method::Calls::TooManyError.new('unexpected number of invocations (1 for 0)') do
    Lookout::Mock::Method::Calls.new(0..0).call
  end

  expect Lookout::Mock::Method::Calls::TooFewError.new('unexpected number of invocations (0 for 1)') do
    Lookout::Mock::Method::Calls.new(1..1).verify
  end

  expect Lookout::Mock::Method::Calls.new(1..1) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls::TooManyError.new('unexpected number of invocations (2 for 1)') do
    Lookout::Mock::Method::Calls.new(1..1).call.call
  end

  expect Lookout::Mock::Method::Calls.new(1..1.0/0) do |o|
    o.call
  end

  expect Lookout::Mock::Method::Calls::TooFewError.new('unexpected number of invocations (0 for 1..)') do
    Lookout::Mock::Method::Calls.new(1..1.0/0).verify
  end

  expect Lookout::Mock::Method::Calls.new(1..1.0/0) do |o|
    o.call.verify
  end

  expect Lookout::Mock::Method::Calls.new(1..1.0/0) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls::TooFewError.new('unexpected number of invocations (0 for 2..)') do
    Lookout::Mock::Method::Calls.new(2..1.0/0).verify
  end

  expect Lookout::Mock::Method::Calls::TooFewError.new('unexpected number of invocations (1 for 2..)') do
    Lookout::Mock::Method::Calls.new(2..1.0/0).call.verify
  end

  expect Lookout::Mock::Method::Calls.new(2..1.0/0) do |o|
    o.call.call.verify
  end

  expect Lookout::Mock::Method::Calls.new(2..1.0/0) do |o|
    o.call.call.call.verify
  end
end
