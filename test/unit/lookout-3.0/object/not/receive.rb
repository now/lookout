# -*- coding: utf-8 -*-

Expectations do
  expect true do
    body = proc{ true }
    Lookout::Object::Not::Receive.new([]).include?(1, &body) ==
      Lookout::Reception.of([], :include?, 1, &body).never
  end
end
