# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Stub::Object do
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :a).define }.a
  end

  expect 1 do
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :a){ 1 }.define }.a
  end

  expect NoMethodError do
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :a).define.undefine }.a
  end

  expect Class.new{ def a() 1 end }.new.to.have.a.equal?(1) do |o|
    Lookout::Stub::Method::Undefined.new(o, :a).define.undefine
  end

  # NOTE: Ruby raises NoMethodError when trying to invoke private methods.
  expect NoMethodError do
    o = Object.new
    class << o; def a() 1 end; private :a; end
    Lookout::Stub::Method::Undefined.new(o, :a).define.undefine
    o.a
  end

  expect 1 do
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :a){ |&block| block.call }.define }.a{ 1 }
  end

  expect 1 do
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :a){ |&block| block.call(1) }.define }.a{ |i| i }
  end

  expect 6 do
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :a){ |&block| block.call(1, 2, 3) }.define }.a{ |i, j, k| i + j + k }
  end

  expect 6 do
    n = 0
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :each){ |&block| [1, 2, 3].each{ |i| block.call(i) } }.define }.each{ |i| n += i }
    n
  end

  expect StandardError do
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :a){ raise StandardError }.define }.a
  end

  expect nil do
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :a).define }.a{ raise StandardError }
    nil
  end
end
