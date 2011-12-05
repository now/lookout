# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::StandardError.new(RuntimeError.new('error'), 'test', 1){ raise 'error' }.evaluate
  end

  expect Lookout::Results::Failures::State.new('test', 1, '#<RuntimeError: b>≠#<RuntimeError: a>: [-b-]{+a+}') do
    Lookout::Expectations::StandardError.new(RuntimeError.new('a'), 'test', 1){ raise 'b' }.evaluate
  end

  expect 'RuntimeError≠StandardError' do
    Lookout::Expectations::StandardError.new(StandardError.new('a'), 'test', 1){ raise 'b' }.evaluate.message
  end
end
