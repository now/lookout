# -*- coding: utf-8 -*-

Expectations do
  expect NoMethodError.
    new("cannot convert upper reception limit to Integer: undefined method `to_int' for nil:NilClass") do
    Object.new.to.receive.a.at_most(nil)
  end

  expect ArgumentError.new('upper reception limit must be positive: -1 < 1') do
    Object.new.to.receive.a.at_most(-1)
  end

  expect ArgumentError.new('upper reception limit must be positive: 0 < 1') do
    Object.new.to.receive.a.at_most(0)
  end

  expect Lookout::Reception do
    Object.new.to.receive.a.at_most(1)
  end

  expect ArgumentError.new('expected reception count must be non-negative: -1 < 0') do
    Object.new.to.receive.a.exactly(-1)
  end

  expect Lookout::Reception do
    Object.new.to.receive.a.exactly(0)
  end

  expect ArgumentError.new('lower reception limit must be positive: -1 < 1') do
    Object.new.to.receive.a.at_least(-1)
  end

  expect ArgumentError.new('lower reception limit must be positive: 0 < 1') do
    Object.new.to.receive.a.at_least(0)
  end

  expect Lookout::Reception do
    Object.new.to.receive.a.at_least(1)
  end

  expect Lookout::Results::Success.new('test', 1) do
    stub.to.receive.call.to_lookout_expected.expect('test', 1){ |o| o.call }.call
  end

  expect Lookout::Results::Failure do
    stub.to.receive.call.to_lookout_expected.expect('test', 1).call
  end

  if RUBY_VERSION < '1.9'
    expect Lookout::Results::Error do
      stub.to.receive.call.to_lookout_expected.expect('test', 1){ raise RuntimeError, 'error', [] }.call
    end
  else
    expect Lookout::Results::Error.new('test', 1, nil, Lookout::Exception.new(RuntimeError.new('error').tap{ |e| e.set_backtrace([]) })) do
      stub.to.receive.call.to_lookout_expected.expect('test', 1){ raise RuntimeError, 'error', [] }.call
    end
  end

  expect Lookout::Results::Error do
    stub.not.to.receive.call.to_lookout_expected.expect('test', 1){ |o| o.call }.call
  end

  expect 'stub#call: unexpected number of invocations (1 for 0)' do
    stub.not.to.receive.call.to_lookout_expected.expect('test', 1){ |o| o.call }.call.exception.message
  end

  expect Lookout::Results::Success.new('test', 1) do
    stub.not.to.receive.call.to_lookout_expected.expect('test', 1).call{ }
  end

  expect Lookout::Results::Error do
    stub.to.receive.call(1).to_lookout_expected.expect('test', 1){ |o| o.call }.call
  end

  expect 'stub#call: unexpected arguments ([]≠[1])' do
    stub.to.receive.call(1).to_lookout_expected.expect('test', 1){ |o| o.call }.call.exception.message
  end
end
