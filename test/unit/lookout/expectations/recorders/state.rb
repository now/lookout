# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Failures::State.new('test', 1, 'expected stub to be running?') do
    stub(:running? => false).to.be.running?.to_lookout_expected.to_lookout_expectation('test', 1).evaluate
  end
end
