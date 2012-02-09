# -*- coding: utf-8 -*-

Expectations do
  expect '[]#empty?' do
    Lookout::Difference::Lookout::Actual::Not.new([], Lookout::Actual::Methods.new.push(:empty?)).message
  end
end
