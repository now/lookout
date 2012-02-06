# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Lookout::State.new('expected [] to include? 1') do
    Lookout::State.new([]).include?(1).to_lookout_expected.difference(:unused)
  end
end
