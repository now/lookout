# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Object::To.new([]).receive == Lookout::Object::To::Receive.new([])
  end
end
