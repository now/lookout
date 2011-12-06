# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new('expected nil not to have nil?') do
    Lookout::Recorders::State::Not::Have.new(nil).nil?.to_lookout_expected.verify
  end

  expect true do
    Lookout::Recorders::State::Not::Have.new(true).nil?.to_lookout_expected.verify
  end
end
