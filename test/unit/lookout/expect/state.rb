# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::State do
    stub(:running? => true).to.be.running?.to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    stub(:running? => true).to.be.running?.to_lookout_expected.actualize('test', 1).call
  end

  expect Lookout::Results::Failures::State.new('test', 1, 'expected stub not to be running?') do
    stub(:running? => true).not.to.be.running?.to_lookout_expected.actualize('test', 1).call
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    stub(:running? => false).not.to.be.running?.to_lookout_expected.actualize('test', 1).call
  end

  expect Lookout::Results::Failures::State.new('test', 1, 'expected stub to be running?') do
    stub(:running? => false).to.be.running?.to_lookout_expected.actualize('test', 1).call
  end
end
