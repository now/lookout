# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Failures::State.new('test', 1, 'expected stub to be running?') do
    Lookout::Expectations::Recorders::State.new(stub(:running? => false).to.be.running?, 'test', 1).evaluate
  end
end
