# -*- coding: utf-8 -*-

Expectations do
  expect 1 do
    Object.new.tap{ |o| Lookout::Stub::Method::Defined::Definition.new(o, :a){ 1 } }.a
  end

  expect 1 do
    Object.new.tap{ |o| Lookout::Stub::Method::Defined::Definition.new(o, :a){ |&block| block.call } }.a{ 1 }
  end

  expect 1 do
    Object.new.tap{ |o| Lookout::Stub::Method::Defined::Definition.new(o, :a){ |&block| block.call(1) } }.a{ |i| i }
  end

  expect 6 do
    Object.new.tap{ |o| Lookout::Stub::Method::Defined::Definition.new(o, :a){ |&block| block.call(1, 2, 3) } }.a{ |i, j, k| i + j + k }
  end

  expect 6 do
    n = 0
    Object.new.tap{ |o| Lookout::Stub::Method::Defined::Definition.new(o, :each){ |&block| [1, 2, 3].each{ |i| block.call(i) } } }.each{ |i| n += i }
    n
  end

  expect StandardError do
    Object.new.tap{ |o| Lookout::Stub::Method::Defined::Definition.new(o, :a){ raise StandardError } }.a
  end

  expect nil do
    Object.new.tap{ |o| Lookout::Stub::Method::Defined::Definition.new(o, :a){ } }.a{ raise StandardError }
    nil
  end

  # NOTE: Ruby raises NoMethodError when trying to invoke private methods.
  expect NoMethodError do
    o = Object.new
    class << o; def a() 1 end; private :a; end
    Lookout::Stub::Method::Defined::Definition.new(o, :a){ 2 }
    o.a
  end

  expect NoMethodError do
    Object.new.tap{ |o| Lookout::Stub::Method::Defined::Definition.new(o, :a){ }.undefine }.a
  end

  expect 1 do
    o = Object.new
    class << o; def a() 1 end end
    Lookout::Stub::Method::Defined::Definition.new(o, :a){ 2 }.undefine
    o.a
  end

  # NOTE: Ruby raises NoMethodError when trying to invoke private methods.
  expect NoMethodError do
    o = Object.new
    class << o; def a() 1 end; private :a; end
    Lookout::Stub::Method::Defined::Definition.new(o, :a){ 2 }.undefine
    o.a
  end

  expect true do
    o = Class.new(Object).new
    inspect = o.method(:inspect)
    Lookout::Stub::Method::Defined::Definition.new(o, :inspect){ 'inspect' }.undefine
    o.method(:inspect) == inspect
  end

  expect Lookout::Stub::Method::Defined::Definition.new(Object.new, :a){ 1 } do |o|
    o.undefine
  end
end
