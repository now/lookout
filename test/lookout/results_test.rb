# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Object.new.extend(Lookout::Results::Fulfilled).to.have.char == "."
  expect Object.new.extend(Lookout::Results::StateBasedFailure).to.have.char == "F"
  expect Object.new.extend(Lookout::Results::BehaviorBasedFailure).to.have.char == "F"
  expect Object.new.extend(Lookout::Results::Error).to.have.char == "E"
  expect Object.new.extend(Lookout::Results::Fulfilled).to.be.fulfilled?
  expect Object.new.extend(Lookout::Results::StateBasedFailure).not.to.be.fulfilled?
  expect Object.new.extend(Lookout::Results::BehaviorBasedFailure).not.to.be.fulfilled?
  expect Object.new.extend(Lookout::Results::Error).not.to.be.fulfilled?
  expect Object.new.extend(Lookout::Results::Fulfilled).not.to.be.error?
  expect Object.new.extend(Lookout::Results::StateBasedFailure).not.to.be.error?
  expect Object.new.extend(Lookout::Results::BehaviorBasedFailure).not.to.be.error?
  expect Object.new.extend(Lookout::Results::Error).to.be.error?
  expect Object.new.extend(Lookout::Results::Fulfilled).not.to.be.failure?
  expect Object.new.extend(Lookout::Results::StateBasedFailure).to.be.failure?
  expect Object.new.extend(Lookout::Results::BehaviorBasedFailure).to.be.failure?
  expect Object.new.extend(Lookout::Results::Error).not.to.be.failure?
end
