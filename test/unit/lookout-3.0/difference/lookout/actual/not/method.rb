# -*- coding: utf-8 -*-

Expectations do
  expect '[]#empty?' do
    Lookout::Difference::Lookout::Actual::Not::Method.new([], Lookout::Actual::Method.new(:empty?)).message
  end
end
