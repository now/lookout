# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::State::Error.new('expected nil not to have nil?') do
    Lookout::State::Not::Have.new(nil).nil?.to_lookout_expected.verify
  end

  expect true do
    Lookout::State::Not::Have.new(true).nil?.to_lookout_expected.verify
  end
end
