# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Lookout::State.new('expected nil not to be nil?') do
    Lookout::State::Not::Be.new(nil).nil?.to_lookout_expected.difference(:unused)
  end

  expect nil do
    Lookout::State::Not::Be.new(true).nil?.to_lookout_expected.difference(:unused)
  end
end
