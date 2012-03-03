# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Stub::Method::Defined.new(Object.new, :a){ 1 } do |o|
    o.undefine.define
  end
end
