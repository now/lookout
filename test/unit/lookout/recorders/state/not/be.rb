# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new(/expected .* not to be nil?/) do
    Lookout::Recorders::State::Not::Be.new(nil).nil?.verify
  end

  expect true do
    Lookout::Recorders::State::Not::Be.new(true).nil?.verify
  end
end
