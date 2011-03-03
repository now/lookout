# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Failures::Behavior.new(nil, 0, nil).not.to.be.error?
  expect Lookout::Results::Failures::Behavior.new(nil, 0, nil).to.be.failure?
  expect Lookout::Results::Failures::Behavior.new(nil, 0, nil).not.to.be.fulfilled?
end
