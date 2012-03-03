# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Undefined.new(stub, :a, Lookout::Mock::Method::Calls.new(0..0)) do |o|
    o.define.undefine
  end

  expect Lookout::Mock::Method::Calls::TooManyError.
    new('""#a: unexpected number of invocations (1 for 0)', 1, 0..0) do
    s = ''
    Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(0..0))
    s.a
  end

  expect Lookout::Mock::Method::Calls::TooManyError.
    new('Klass.a: unexpected number of invocations (1 for 0)', 1, 0..0) do
    s = Class.new
    class << s
      def inspect
        'Klass'
      end
    end
    Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(0..0))
    s.a
  end

  expect Lookout::Mock::Method::Calls::TooManyError.
    new('(cannot inspect object: error)#a: unexpected number of invocations (1 for 0)', 1, 0..0) do
    s = stub(:inspect => proc{ raise 'error' } )
    Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(0..0))
    s.a
  end

  expect Lookout::Mock::Method::Undefined.new(stub, :a, Lookout::Mock::Method::Calls.new(0..1)) do |o|
    o.define.undefine
  end

  expect Lookout::Mock::Method::Undefined.new('', :a, Lookout::Mock::Method::Calls.new(0..1).call) do |o|
    s = ''
    m = Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(0..1))
    s.a
    m.undefine
  end

  expect Lookout::Mock::Method::Calls::TooManyError do
    s = ''
    Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(0..1))
    s.a
    s.a
  end

  expect Lookout::Mock::Method::Calls::TooFewError.
    new('""#a: unexpected number of invocations (0 for 1)', 0, 1..1) do
    s = ''
    m = Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(1..1))
    m.undefine
  end

  expect Lookout::Mock::Method::Undefined.new('', :a, Lookout::Mock::Method::Calls.new(1..1).call) do |o|
    s = ''
    m = Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(1..1))
    s.a
    m.undefine
  end

  expect Lookout::Mock::Method::Calls::TooManyError do
    s = ''
    Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(1..1))
    s.a
    s.a
  end

  expect Lookout::Mock::Method::Calls::TooFewError do
    s = ''
    m = Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(1..1.0/0))
    m.undefine
  end

  expect Lookout::Mock::Method::Undefined.new('', :a, Lookout::Mock::Method::Calls.new(1..1.0/0).call) do |o|
    s = ''
    m = Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(1..1.0/0))
    s.a
    m.undefine
  end

  expect Lookout::Mock::Method::Undefined.new('', :a, Lookout::Mock::Method::Calls.new(1..1.0/0).call.call) do |o|
    s = ''
    m = Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(1..1.0/0))
    s.a
    s.a
    m.undefine
  end

  expect Lookout::Mock::Method::Arguments::Error.new('""#a: unexpected arguments ([]≠[1])') do
    s = ''
    Lookout::Mock::Method::Defined.new(s, :a, Lookout::Mock::Method::Calls.new(1..1), 1)
    s.a
  end
end
