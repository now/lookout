# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::State::Error.new('expected [] to include? 1') do
    Lookout::State.new([]).include?(1).to_lookout_expected.verify
  end
end
