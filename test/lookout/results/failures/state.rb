# -*- coding: utf-8 -*-

Expectations do
  expect Object.new.extend(Lookout::Results::Failures::State).not.to.be.error?
  expect Object.new.extend(Lookout::Results::Failures::State).to.be.failure?
  expect Object.new.extend(Lookout::Results::Failures::State).not.to.be.fulfilled?
end
