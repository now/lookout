# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Stub::Object do
    Object.new.tap{ |o| Lookout::Stub::Method::Undefined.new(o, :a).define }.a
  end

  expect Lookout::Stub::Method::Undefined.new(:object, :a) do
    Lookout::Stub::Method::Undefined.new(:object, :a)
  end
end
