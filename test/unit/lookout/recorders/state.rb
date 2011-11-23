# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new(/expected .* to be nil?/) do
    Lookout::Recorders::State::Be.new(true).nil?.verify
  end

  expect true do
    Lookout::Recorders::State::Be.new(nil).nil?.verify
  end
end
