# -*- coding: utf-8 -*-

Expectations do
  expect 'error' do
    Lookout::Exception.new(RuntimeError.new('error')).message
  end

  if ''.respond_to? :encode
    expect "cannot retrieve error message: error" do
      Lookout::Exception.new(stub(:to_str => proc{ raise 'error' })).message
    end

    expect "cannot retrieve error message: can't convert Lookout::Stub to String (Lookout::Stub#to_s gives NilClass)" do
      Lookout::Exception.new(stub(:to_str => nil, :to_s => nil)).message
    end

    expect 'cannot encode error message for output: "\xE2" from ASCII-8BIT to UTF-8; dumping instead: "can\xE2\x80\x99t"' do
      Lookout::Exception.new(stub(:to_str => 'can’t'.force_encoding('ASCII-8BIT'))).message
    end

    expect 'cannot encode error message for output: "\xE2" from ASCII-8BIT to UTF-8' do
      stub('can’t'.force_encoding('ASCII-8BIT'), :dump => proc{ raise 'error' }){ |message|
        Lookout::Exception.new(stub(:to_str => message)).message
      }
    end
  end

  expect 'unhandled exception' do
    stub(RuntimeError.new(''), :message => proc{ raise 'inner' }){ |exception|
      Lookout::Exception.new(exception).header
    }
  end

  expect 'unhandled exception' do
    Lookout::Exception.new(RuntimeError.new('')).header
  end

  expect 'unhandled exception' do
    Lookout::Exception.new(RuntimeError.new("\n")).header
  end

  expect 'StandardError' do
    Lookout::Exception.new(StandardError.new('')).header
  end

  expect 'error' do
    stub(Class.new(StandardError).new('error'), :class => stub(:name => nil)){ |exception|
      Lookout::Exception.new(exception).header
    }
  end

  expect 'error (cannot determine name of class of exception: inner)' do
    stub(Class.new(StandardError).new('error'), :class => stub(:name => proc{ raise 'inner' })){ |exception|
      Lookout::Exception.new(exception).header
    }
  end

  expect 'error' do
    Lookout::Exception.new(Class.new(StandardError).new('error')).header
  end

  expect 'error' do
    Lookout::Exception.new(Class.new(StandardError).new("error\n")).header
  end

  expect 'error (StandardError)' do
    Lookout::Exception.new(StandardError.new('error')).header
  end

  expect 'error (StandardError)' do
    Lookout::Exception.new(StandardError.new("error\n")).header
  end

  expect "line 1 (StandardError)\nline 2\nline 3" do
    Lookout::Exception.new(StandardError.new("line 1\nline 2\nline 3")).header
  end

  expect StandardError do
    Lookout::Exception.new(StandardError.new).type
  end

  expect Lookout::Exception::Unknown do
    stub(StandardError.new('error'), :class => proc{ raise 'inner' }){ |exception|
      Lookout::Exception.new(exception).type
    }
  end

  expect 'StandardError' do
    Lookout::Exception.new(StandardError.new).type_name
  end

  expect 'cannot determine name of class of exception: inner' do
    stub(StandardError.new('error'), :class => stub(:name => proc{ raise 'inner' })){ |exception|
      Lookout::Exception.new(exception).type_name
    }
  end

  expect 'cannot determine name of class of exception: cannot determine class of exception: inner' do
    stub(StandardError.new('error'), :class => proc{ raise 'inner' }){ |exception|
      Lookout::Exception.new(exception).type_name
    }
  end

  expect "line 1 (StandardError)\nline 2\n\tfrom a:1\n\tfrom b:2" do
    Lookout::Exception.new(StandardError.new("line 1\nline 2").tap{ |e| e.set_backtrace ['a:1', 'b:2'] }).format
  end
end
