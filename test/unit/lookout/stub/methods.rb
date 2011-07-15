# -*- coding: utf-8 -*-

Expectations do
  expect false do
    Object.new.nil?
  end

  expect true do
    Object.new.tap{ |o|
      Lookout::Stub::Methods.new.define(o, :nil?){ true }
    }.nil?
  end

  expect false do
    Object.new.tap{ |o|
      Lookout::Stub::Methods.new.define(o, :nil?){ true }.undefine
    }.nil?
  end
end
