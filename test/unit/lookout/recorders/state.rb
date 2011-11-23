# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new(/expected .* to be nil?/) do
    Lookout::Recorders::State.new(stub(:nil? => false), false, :be).nil?.verify
  end

  expect true do
    Lookout::Recorders::State.new(nil, false, :be).nil?.verify
  end

  expect Lookout::Recorders::State::Error.new(/expected .* not to be nil?/) do
    Lookout::Recorders::State.new(nil, true, :be).nil?.verify
  end

  expect true do
    Lookout::Recorders::State.new(stub(:nil? => false), true, :be).nil?.verify
  end
end
