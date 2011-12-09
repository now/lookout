# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    stub(:running? => true).to.be.running?.to_lookout_expected.to_lookout_expectation('test', 1).evaluate
  end

  expect Lookout::Results::Failures::State.new('test', 1, 'expected stub not to be running?') do
    stub(:running? => true).not.to.be.running?.to_lookout_expected.to_lookout_expectation('test', 1).evaluate
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    stub(:running? => false).not.to.be.running?.to_lookout_expected.to_lookout_expectation('test', 1).evaluate
  end

  expect Lookout::Results::Failures::State.new('test', 1, 'expected stub to be running?') do
    stub(:running? => false).to.be.running?.to_lookout_expected.to_lookout_expectation('test', 1).evaluate
  end
end