# -*- coding: utf-8 -*-

Expectations do
  expect 'unhandled exception' do
    Lookout::Results::Error::Exception.new(stub(RuntimeError.new('')).message{ raise 'inner' }).message
  end

  expect 'unhandled exception' do
    Lookout::Results::Error::Exception.new(RuntimeError.new('')).message
  end

  expect 'unhandled exception' do
    Lookout::Results::Error::Exception.new(RuntimeError.new("\n")).message
  end

  expect 'StandardError' do
    Lookout::Results::Error::Exception.new(StandardError.new('')).message
  end

  expect 'error' do
    Lookout::Results::Error::Exception.new(stub(Class.new(StandardError).new('error')).class{ stub(:name => nil) }).message
  end

  expect 'error (cannot determine class name of exception: inner)' do
    Lookout::Results::Error::Exception.new(stub(StandardError.new('error')).class{ stub(:name => proc{ raise 'inner' }) }).message
  end

  expect 'error' do
    Lookout::Results::Error::Exception.new(Class.new(StandardError).new('error')).message
  end

  expect 'error' do
    Lookout::Results::Error::Exception.new(Class.new(StandardError).new("error\n")).message
  end

  expect 'error (StandardError)' do
    Lookout::Results::Error::Exception.new(StandardError.new('error')).message
  end

  expect 'error (StandardError)' do
    Lookout::Results::Error::Exception.new(StandardError.new("error\n")).message
  end

  expect "line 1 (StandardError)\nline 2\nline 3" do
    Lookout::Results::Error::Exception.new(StandardError.new("line 1\nline 2\nline 3")).message
  end

  expect "line 1 (StandardError)\nline 2\n\tfrom a:1\n\tfrom b:2" do
    Lookout::Results::Error::Exception.new(StandardError.new("line 1\nline 2").tap{ |e| e.set_backtrace ['a:1', 'b:2'] }).to_s
  end
end
