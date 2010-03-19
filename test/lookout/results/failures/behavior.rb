# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Object.new.extend(Lookout::Results::Failures::Behavior).not.to.be.error?
  expect Object.new.extend(Lookout::Results::Failures::Behavior).to.be.failure?
  expect Object.new.extend(Lookout::Results::Failures::Behavior).not.to.be.fulfilled?
end
