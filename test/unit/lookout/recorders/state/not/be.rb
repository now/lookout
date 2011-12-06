# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new('expected nil not to be nil?') do
    Lookout::Recorders::State::Not::Be.new(nil).nil?.subject!.last.call
  end

  expect true do
    Lookout::Recorders::State::Not::Be.new(true).nil?.subject!.last.call
  end
end
