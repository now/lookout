# -*- coding: utf-8 -*-

Expectations do
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

  expect Lookout::Stub::Method::Undefined.new(Object.new, :a){ 1 } do |o|
    o.define.undefine
  end
end
