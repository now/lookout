# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Object::Not.new([]).to.receive == Lookout::Object::Not::Receive.new([])
  end
end
