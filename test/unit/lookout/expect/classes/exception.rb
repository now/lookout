# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Classes::Exception do
    SystemExit.to_lookout_expected.expect('test', 1){ exit }
  end

  expect Lookout::Results::Success.new('test', 1) do
    begin
      SystemExit.to_lookout_expected.expect('test', 1){ exit }.call
    rescue SystemExit
      raise 'SystemExit not caught'
    end
  end

  expect Lookout::Results::Success.new('test', 1) do
    StandardError.to_lookout_expected.expect('test', 1){ raise 'error' }.call
  end

  expect Lookout::Results::Success.new('test', 1) do
    RuntimeError.to_lookout_expected.expect('test', 1){ raise 'error' }.call
  end

  expect Lookout::Results::Error do
    ArgumentError.to_lookout_expected.expect('test', 1){ raise 'error' }.call
  end

  expect Lookout::Results::Error do
    ArgumentError.to_lookout_expected.expect('test', 1){
      raise Class.new(RuntimeError){
        def class
          raise 'no class for you'
        end
      }
    }.call
  end
end
