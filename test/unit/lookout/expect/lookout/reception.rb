# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Lookout::Reception do
    stub.to.receive.call.to_lookout_expected.expect('test', 1)
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

  expect Lookout::Results::Success.new('test', 1) do
    'a'.to.receive.call.once.to_lookout_expected.expect('test', 1){ |o| o.call }.call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Reception.
          new(0,
              1..1,
              '"a"#call: unexpected number of invocations (0 for 1)')) do
    'a'.to.receive.call.once.to_lookout_expected.expect('test', 1).call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Reception.
          new(0,
              1..1,
              '"a"#call: unexpected number of invocations (0 for 1)')) do
    'a'.to.receive.call.once.to_lookout_expected.expect('test', 1){ }.call
  end
end
