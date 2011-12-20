# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Classes::Exception do
    SystemExit.to_lookout_expected.actualize('test', 1){ exit }
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    begin
      SystemExit.to_lookout_expected.actualize('test', 1){ exit }.call
    rescue SystemExit
      raise 'SystemExit not caught'
    end
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    StandardError.to_lookout_expected.actualize('test', 1){ raise 'error' }.call
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    RuntimeError.to_lookout_expected.actualize('test', 1){ raise 'error' }.call
  end

  expect Lookout::Results::Error do
    ArgumentError.to_lookout_expected.actualize('test', 1){ raise 'error' }.call
  end
end
