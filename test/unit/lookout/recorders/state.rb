# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new(/expected .* to be nil?/) do
    Lookout::Recorders::State::Be.new(stub(:nil? => false), false).nil?.verify
  end

  expect true do
    Lookout::Recorders::State::Be.new(nil, false).nil?.verify
  end

  expect Lookout::Recorders::State::Error.new(/expected .* not to be nil?/) do
    Lookout::Recorders::State::Be.new(nil, true).nil?.verify
  end

  expect true do
    Lookout::Recorders::State::Be.new(stub(:nil? => false), true).nil?.verify
  end
end
