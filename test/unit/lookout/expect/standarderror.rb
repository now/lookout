# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expect::StandardError.
      new(Lookout::Expected::StandardError.
          new(RuntimeError.new('error')), 'test', 1){ raise 'error' }.call
  end

  expect Lookout::Results::Failures::State.new('test', 1, '#<RuntimeError: b>≠#<RuntimeError: a>: [-b-]{+a+}') do
    Lookout::Expect::StandardError.
      new(Lookout::Expected::StandardError.
          new(RuntimeError.new('a')), 'test', 1){ raise 'b' }.call
  end

  expect 'RuntimeError≠StandardError' do
    Lookout::Expect::StandardError.
      new(Lookout::Expected::StandardError.
          new(StandardError.new('a')), 'test', 1){ raise 'b' }.call.message
  end
end
