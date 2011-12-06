# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::Recorders::Reception.new(stub.to.receive.call, 'test', 1){ |o| o.call }.evaluate
  end

  expect Lookout::Results::Failures::Behavior.new('test', 1, 'expected stub.call(*args, &block) to be called at least once') do
    Lookout::Expectations::Recorders::Reception.new(stub.to.receive.call, 'test', 1).evaluate
  end

  expect Lookout::Results::Error.new('test', 1, nil, RuntimeError.new('error').tap{ |e| e.set_backtrace([]) }) do
    Lookout::Expectations::Recorders::Reception.new(stub.to.receive.call, 'test', 1){ raise RuntimeError, 'error', [] }.evaluate
  end
end
