# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Lookout::State.new('expected true to be nil?') do
    true.to.be.nil?.to_lookout_expected.difference(:unused)
  end

  expect nil do
    nil.to.be.nil?.to_lookout_expected.difference(:unused)
  end

  expect Lookout::Difference::Lookout::State.new('expected nil not to be nil?') do
    nil.not.to.be.nil?.to_lookout_expected.difference(:unused)
  end

  expect nil do
    true.not.to.be.nil?.to_lookout_expected.difference(:unused)
  end
end
