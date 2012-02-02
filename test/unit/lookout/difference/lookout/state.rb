# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::State.new('expected stub not to be running?')) do
    stub(:running? => true).not.to.be.running?.to_lookout_expected.actualize('test', 1).call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::State.new('expected stub to be running?')) do
    stub(:running? => false).to.be.running?.to_lookout_expected.actualize('test', 1).call
  end
end
