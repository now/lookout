# -*- coding: utf-8 -*-

Expectations do
  # In Ruby 1.8.7, exceptions can’t be compared properly.
  if RuntimeError.new == RuntimeError.new
    expect true do
      Lookout::Results::Error.new('a', 1, nil, Lookout::Exception.new(RuntimeError.new)) ==
        Lookout::Results::Error.new('a', 1, nil, Lookout::Exception.new(RuntimeError.new))
    end

    expect false do
      Lookout::Results::Error.new('a', 1, nil, Lookout::Exception.new(RuntimeError.new)) ==
                                  Lookout::Results::Error.new('a', 1, 'a', Lookout::Exception.new(RuntimeError.new))
    end

    expect false do
Lookout::Results::Error.new('a', 1, nil, Lookout::Exception.new(RuntimeError.new)) ==
                            Lookout::Results::Error.new('a', 1, nil, Lookout::Exception.new(StandardError.new))
    end

    expect Lookout::Exception.new(RuntimeError.new('error')) do
      Lookout::Results::Error.new('test', 1, 'a≠b', Lookout::Exception.new(RuntimeError.new('error'))).exception
    end
  end

  expect "test:1: error (RuntimeError)\n" do
    Lookout::Results::Error.new('test', 1, nil, Lookout::Exception.new(RuntimeError.new('error'))).to_s
  end

  expect "test:1: a≠b: error (RuntimeError)\n" do
    Lookout::Results::Error.new('test', 1, 'a≠b', Lookout::Exception.new(RuntimeError.new('error'))).to_s
  end

  expect 'a≠b' do
    Lookout::Results::Error.new('test', 1, 'a≠b', Lookout::Exception.new(RuntimeError.new('error'))).message
  end
end
