# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    begin
      Lookout::Expect::Classes::Exception.
        new(Lookout::Expected::Classes::Exception.
            new(SystemExit), 'test', 1){ exit }.call
    rescue SystemExit
      raise 'SystemExit not caught'
    end
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expect::Classes::Exception.
      new(Lookout::Expected::Classes::Exception.
          new(StandardError), 'test', 1){ raise 'error' }.call
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expect::Classes::Exception.
      new(Lookout::Expected::Classes::Exception.
          new(RuntimeError), 'test', 1){ raise 'error' }.call
  end

  expect Lookout::Results::Error do
    Lookout::Expect::Classes::Exception.
      new(Lookout::Expected::Classes::Exception.
          new(ArgumentError), 'test', 1){ raise 'error' }.call
  end
end
