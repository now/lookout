# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    begin
      Lookout::Expectations::Classes::StandardError.new(SystemExit, 'test', 1){ exit }.evaluate
    rescue SystemExit
      raise 'SystemExit not caught'
    end
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::Classes::StandardError.new(StandardError, 'test', 1){ raise 'error' }.evaluate
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::Classes::StandardError.new(RuntimeError, 'test', 1){ raise 'error' }.evaluate
  end

  expect Lookout::Results::Error do
    Lookout::Expectations::Classes::StandardError.new(ArgumentError, 'test', 1){ raise 'error' }.evaluate
  end
end
