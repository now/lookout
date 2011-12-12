# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expectations::Recorders::State do
    Object.new.to.be.running?.to_lookout_expected.to_lookout_expectation('test', 1)
  end

  expect true do
    Lookout::Expected::Recorders::State.new(nil, proc{ true }).verify
  end

  expect false do
    Lookout::Expected::Recorders::State.new(nil, proc{ false }).verify
  end
end
