# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect 1 do
    results = Lookout::Suite::Results.new
    results << Object.new.extend(Lookout::Results::Fulfilled)
    results.fulfillments.size
  end

  expect 0 do
    results = Lookout::Suite::Results.new
    results << Object.new.extend(Lookout::Results::Fulfilled)
    results.errors.size
  end

  expect Lookout::Suite::Results.new.not.to.have.succeeded? do |results|
    results << Object.new.extend(Lookout::Results::StateBasedFailure)
    results << Object.new.extend(Lookout::Results::Fulfilled)
  end

  expect Lookout::Suite::Results.new.not.to.have.succeeded? do |results|
    results << Object.new.extend(Lookout::Results::BehaviorBasedFailure)
    results << Object.new.extend(Lookout::Results::Fulfilled)
  end

  expect Lookout::Suite::Results.new.to.have.succeeded? do |results|
    results << Object.new.extend(Lookout::Results::Fulfilled)
    results << Object.new.extend(Lookout::Results::Fulfilled)
  end

end
