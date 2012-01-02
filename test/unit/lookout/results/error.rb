# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Results::Error.new('a', 1, nil, RuntimeError.new.tap{ |e| e.set_backtrace [] }) ==
      Lookout::Results::Error.new('a', 1, nil, RuntimeError.new.tap{ |e| e.set_backtrace [] })
  end

  expect false do
    Lookout::Results::Error.new('a', 1, nil, RuntimeError.new.tap{ |e| e.set_backtrace [] }) ==
      Lookout::Results::Error.new('a', 1, 'a', RuntimeError.new.tap{ |e| e.set_backtrace [] })
  end

  expect false do
    Lookout::Results::Error.new('a', 1, nil, RuntimeError.new.tap{ |e| e.set_backtrace [] }) ==
      Lookout::Results::Error.new('a', 1, nil, StandardError.new.tap{ |e| e.set_backtrace [] })
  end

  expect "test:1: error (RuntimeError)\n" do
    Lookout::Results::Error.new('test', 1, nil, RuntimeError.new('error')).to_s
  end

  expect "test:1: a≠b: error (RuntimeError)\n" do
    Lookout::Results::Error.new('test', 1, 'a≠b', RuntimeError.new('error')).to_s
  end

  expect 'a≠b' do
    Lookout::Results::Error.new('test', 1, 'a≠b', RuntimeError.new('error')).message
  end
end
