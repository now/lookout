# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Stub::Object do
    Object.new.tap{ |o| Lookout::Stub::Method.new(o, :a).define }.a
  end

  expect 1 do
    Object.new.tap{ |o| Lookout::Stub::Method.new(o, :a){ 1 }.define }.a
  end

  expect NoMethodError do
    Object.new.tap{ |o| Lookout::Stub::Method.new(o, :a).define.undefine }.a
  end

  expect Class.new{ def a() 1 end }.new.to.have.a.equal?(1) do |o|
    Lookout::Stub::Method.new(o, :a).define.undefine
  end

  # NOTE: Ruby returs NoMethodError when trying to invoke private methods.
  expect NoMethodError do
    o = Object.new
    class << o; def a() 1 end; private :a; end
    Lookout::Stub::Method.new(o, :a).define.undefine
    o.a
  end

  expect 1 do
    n = 0
    Object.new.tap{ |o| Lookout::Stub::Method.new(o, :a).yield(1).define }.a{ |i| n = i }
    n
  end

  expect 6 do
    n = 0
    Object.new.tap{ |o|
      Lookout::Stub::Method.new(o, :a).yield(1, 2, 3).define
      3.times{ o.a{ |i| n += i } }
    }
    n
  end

  expect 6 do
    n = 0
    Object.new.tap{ |o| Lookout::Stub::Method.new(o, :a).yield([1, 2, 3]).define }.a{ |i, j, k| n += i; n += j; n += k }
    n
  end

  expect StandardError do
    Object.new.tap{ |o| Lookout::Stub::Method.new(o, :a){ raise StandardError }.define }.a
  end

  expect nil do
    Object.new.tap{ |o| Lookout::Stub::Method.new(o, :a).define }.a{ raise StandardError }
    nil
  end

  expect 1 do
    n = 0
    Object.new.tap{ |o| Lookout::Stub::Method.new(o, :each).each(1).define }.each{ |i| n += i }
    n
  end

  expect 6 do
    n = 0
    Object.new.tap{ |o| Lookout::Stub::Method.new(o, :each).each(1, 2, 3).define }.each{ |i| n += i }
    n
  end
end
