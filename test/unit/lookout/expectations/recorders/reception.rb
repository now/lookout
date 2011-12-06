# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    stub.to.receive.call.to_lookout_expected.to_lookout_expectation('test', 1){ |o| o.call }.evaluate
  end

  expect Lookout::Results::Failures::Behavior.new('test', 1, 'expected stub.call(*args, &block) to be called at least once') do
    stub.to.receive.call.to_lookout_expected.to_lookout_expectation('test', 1).evaluate
  end

  expect Lookout::Results::Error.new('test', 1, nil, RuntimeError.new('error').tap{ |e| e.set_backtrace([]) }) do
    stub.to.receive.call.to_lookout_expected.to_lookout_expectation('test', 1){ raise RuntimeError, 'error', [] }.evaluate
  end

  expect Lookout::Results::Failures::Behavior.new('test', 1, 'expected stub.call(*args, &block) not to be called') do
    stub.not.to.receive.call.to_lookout_expected.to_lookout_expectation('test', 1){ |o| o.call }.evaluate
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    stub.not.to.receive.call.to_lookout_expected.to_lookout_expectation('test', 1).evaluate{ }
  end
end
