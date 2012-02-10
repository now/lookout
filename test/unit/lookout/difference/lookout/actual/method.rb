# -*- coding: utf-8 -*-

Expectations do
  expect '¬[1]#empty?' do
    Lookout::Difference::Lookout::Actual::Method.new([1], Lookout::Actual::Method.new(:empty?)).message
  end
end
