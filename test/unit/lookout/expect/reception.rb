# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Reception do
    stub.to.receive.call.to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Results::Success.new('test', 1) do
    stub.to.receive.call.to_lookout_expected.actualize('test', 1){ |o| o.call }.call
  end

  expect Lookout::Results::Failures::Behavior.new('test', 1, 'expected stub.call(*args, &block) to be called at least once') do
    stub.to.receive.call.to_lookout_expected.actualize('test', 1).call
  end

  expect Lookout::Results::Error.new('test', 1, nil, RuntimeError.new('error').tap{ |e| e.set_backtrace([]) }) do
    stub.to.receive.call.to_lookout_expected.actualize('test', 1){ raise RuntimeError, 'error', [] }.call
  end

  expect Lookout::Results::Failures::Behavior.new('test', 1, 'expected stub.call(*args, &block) not to be called') do
    stub.not.to.receive.call.to_lookout_expected.actualize('test', 1){ |o| o.call }.call
  end

  expect Lookout::Results::Success.new('test', 1) do
    stub.not.to.receive.call.to_lookout_expected.actualize('test', 1).call{ }
  end

  expect Lookout::Results::Failures::Behavior.new('test', 1, 'stub.call(1): unexpected arguments: ()≠(1)') do
    stub.to.receive.call(1).to_lookout_expected.actualize('test', 1){ |o| o.call }.call
  end
end
