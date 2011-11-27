# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::State.new(2, 'test', 1){ 2 }.evaluate
  end

  expect Lookout::Results::Error do
    Lookout::Expectations::State.new(stub(:== => proc{ raise }), 'test', 1){ 2 }.evaluate
  end

  expect Lookout::Results::Failures::State.new('test', 1, '3≠2') do
    Lookout::Expectations::State.new(2, 'test', 1){ 3 }.evaluate
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::State.new(RuntimeError.new('error'), 'test', 1){ raise 'error' }.evaluate
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    begin
      Lookout::Expectations::State.new(SystemExit, 'test', 1){ exit }.evaluate
    rescue SystemExit
      raise 'SystemExit not caught'
    end
  end

  expect Lookout::Results::Failures::State.new('test', 1, '#<RuntimeError: b>≠#<RuntimeError: a>: [-b-]{+a+}') do
    Lookout::Expectations::State.new(RuntimeError.new('a'), 'test', 1){ raise 'b' }.evaluate
  end

  expect Lookout::Results::Error do
    Lookout::Expectations::State.new(StandardError, 'test', 1){ raise 'error' }.evaluate
  end

  expect 'RuntimeError≠StandardError' do
    Lookout::Expectations::State.new(StandardError, 'test', 1){ raise 'error' }.evaluate.message
  end

  expect 'RuntimeError≠StandardError' do
    Lookout::Expectations::State.new(StandardError.new('a'), 'test', 1){ raise 'b' }.evaluate.message
  end

  expect nil do
    Lookout::Expectations::State.new('a', 'test', 1){ raise 'b' }.evaluate.message
  end
end
