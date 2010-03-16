# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Object.new.extend(Lookout::Results::Fulfilled).to.be.fulfilled?
  expect Object.new.extend(Lookout::Results::Failures::State).not.to.be.fulfilled?
  expect Object.new.extend(Lookout::Results::Failures::Behavior).not.to.be.fulfilled?
  expect Object.new.extend(Lookout::Results::Error).not.to.be.fulfilled?
  expect Object.new.extend(Lookout::Results::Fulfilled).not.to.be.error?
  expect Object.new.extend(Lookout::Results::Failures::State).not.to.be.error?
  expect Object.new.extend(Lookout::Results::Failures::Behavior).not.to.be.error?
  expect Object.new.extend(Lookout::Results::Error).to.be.error?
  expect Object.new.extend(Lookout::Results::Fulfilled).not.to.be.failure?
  expect Object.new.extend(Lookout::Results::Failures::State).to.be.failure?
  expect Object.new.extend(Lookout::Results::Failures::Behavior).to.be.failure?
  expect Object.new.extend(Lookout::Results::Error).not.to.be.failure?
end
