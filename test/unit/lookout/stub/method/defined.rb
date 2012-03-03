# -*- coding: utf-8 -*-

Expectations do
  expect 1 do
    Object.new.tap{ |o| Lookout::Stub::Method::Defined.new(o, :a){ 1 } }.a
  end

  expect 1 do
    o = Object.new
    class << o; def a() 1 end end
    Lookout::Stub::Method::Defined.new(o, :a){ 2 }.undefine
    o.a
  end

  expect Lookout::Stub::Method::Undefined.new(Object.new, :a){ 1 } do |o|
    o.define.undefine
  end
end
