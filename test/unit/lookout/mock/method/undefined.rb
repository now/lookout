# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Defined.
    new(Object.new, :a, Lookout::Mock::Method::Calls.new(0..0), 1, 2, 3){ } do |o|
    o.undefine.define
  end
end
