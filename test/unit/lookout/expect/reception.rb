# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Reception do
    stub.to.receive.call.to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Results::Success.new('test', 1) do
    stub.to.receive.call.to_lookout_expected.actualize('test', 1){ |o| o.call }.call
  end

  expect Lookout::Results::Failures::Behavior.new('test', 1, 'stub#call calls: 0<1') do
    stub.to.receive.call.to_lookout_expected.actualize('test', 1).call
  end

  if RUBY_VERSION < '1.9'
    expect Lookout::Results::Error do
      stub.to.receive.call.to_lookout_expected.actualize('test', 1){ raise RuntimeError, 'error', [] }.call
    end
  else
    expect Lookout::Results::Error.new('test', 1, nil, RuntimeError.new('error').tap{ |e| e.set_backtrace([]) }) do
      stub.to.receive.call.to_lookout_expected.actualize('test', 1){ raise RuntimeError, 'error', [] }.call
    end
  end

  expect Lookout::Results::Failures::Behavior.new('test', 1, 'stub#call calls: 1≠0') do
    stub.not.to.receive.call.to_lookout_expected.actualize('test', 1){ |o| o.call }.call
  end

  expect Lookout::Results::Success.new('test', 1) do
    stub.not.to.receive.call.to_lookout_expected.actualize('test', 1).call{ }
  end

  expect Lookout::Results::Failures::Behavior.new('test', 1, 'stub received #call(), expected #call(1)') do
    stub.to.receive.call(1).to_lookout_expected.actualize('test', 1){ |o| o.call }.call
  end
end
