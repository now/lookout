# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Lookout::State.new('expected nil not to have nil?') do
    Lookout::State::Not::Have.new(nil).nil?.to_lookout_expected.difference(:unused)
  end

  expect nil do
    Lookout::State::Not::Have.new(true).nil?.to_lookout_expected.difference(:unused)
  end
end
