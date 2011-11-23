# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new(/expected .* not to have nil?/) do
    Lookout::Recorders::State::Not::Have.new(nil).nil?.subject!(nil).last.call
  end

  expect true do
    Lookout::Recorders::State::Not::Have.new(true).nil?.subject!(nil).last.call
  end
end
