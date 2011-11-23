# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new(/expected .* not to be nil?/) do
    Lookout::Recorders::State::Not::Be.new(nil).nil?.subject!(nil).last.call
  end

  expect true do
    Lookout::Recorders::State::Not::Be.new(true).nil?.subject!(nil).last.call
  end
end
