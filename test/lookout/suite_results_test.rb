# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do
  expect 1 do
    results = Lookout::SuiteResults.new(Silent)
    results << Object.new.extend(Lookout::Results::Fulfilled)
    results.fulfilled.size
  end

  expect 0 do
    results = Lookout::SuiteResults.new(Silent)
    results << Object.new.extend(Lookout::Results::Fulfilled)
    results.errors.size
  end

  expect Lookout::SuiteResults.new(Silent).not.to.have.succeeded? do |results|
    results << Object.new.extend(Lookout::Results::StateBasedFailure)
    results << Object.new.extend(Lookout::Results::Fulfilled)
  end

  expect Lookout::SuiteResults.new(Silent).not.to.have.succeeded? do |results|
    results << Object.new.extend(Lookout::Results::BehaviorBasedFailure)
    results << Object.new.extend(Lookout::Results::Fulfilled)
  end

  expect Lookout::SuiteResults.new(Silent).to.have.succeeded? do |results|
    results << Object.new.extend(Lookout::Results::Fulfilled)
    results << Object.new.extend(Lookout::Results::Fulfilled)
  end

end
