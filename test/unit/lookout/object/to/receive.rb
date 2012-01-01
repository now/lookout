# -*- coding: utf-8 -*-

Expectations do
  expect true do
    body = proc{ true }
    Lookout::Object::To::Receive.new([]).include?(1, &body) ==
      Lookout::Reception.new([], :include?, 1, &body)
  end
end
