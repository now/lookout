# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Reception do
    Object.new.to.receive.a.at_most(1)
  end

  expect NoMethodError.new("cannot convert upper mock method invocation limit to Integer: undefined method `to_int' for nil:NilClass") do
    Object.new.to.receive.a.at_most(nil)
  end
end
