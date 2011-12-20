# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::State do
    Object.new.to.be.running?.to_lookout_expected.actualize('test', 1)
  end

  expect true do
    Lookout::Expected::State.new(nil, proc{ true }).verify
  end

  expect false do
    Lookout::Expected::State.new(nil, proc{ false }).verify
  end
end
