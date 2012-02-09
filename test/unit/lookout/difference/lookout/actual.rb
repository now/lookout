# -*- coding: utf-8 -*-

Expectations do
  expect '¬[1]#empty?' do
    Lookout::Difference::Lookout::Actual.new([1], Lookout::Actual::Methods.new.push(:empty?)).message
  end
end
