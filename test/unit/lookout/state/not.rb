# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Lookout::State.new('expected [1] not to include? 1') do
    Lookout::State::Not.new([1]).include?(1).to_lookout_expected.difference(:unused)
  end
end
