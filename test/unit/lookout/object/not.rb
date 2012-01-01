# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::State::Not do
    Lookout::Object::Not.new([]).include? 1
  end

  expect NoMethodError do
    Lookout::Object::Not.new([]).length
  end
end
