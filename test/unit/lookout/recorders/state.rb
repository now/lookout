# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new('expected [] to include? 1') do
    Lookout::Recorders::State.new([]).include?(1).to_lookout_expected.verify
  end
end
