# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::State do
    Lookout::Object::To.new([]).include? 1
  end

  expect NoMethodError do
    Lookout::Object::To.new([]).length
  end
end
