# -*- coding: utf-8 -*-

Expectations do
  expect 1 do
    results = Lookout::Results.new
    results << Lookout::Results::Fulfilled.new(nil, 0)
    results.fulfillments.size
  end

  expect 0 do
    results = Lookout::Results.new
    results << Lookout::Results::Fulfilled.new(nil, 0)
    results.errors.size
  end

  expect Lookout::Results.new.not.to.have.succeeded? do |results|
    results << Lookout::Results::Failures::State.new(nil, 0, nil)
    results << Lookout::Results::Fulfilled.new(nil, 0)
  end

  expect Lookout::Results.new.not.to.have.succeeded? do |results|
    results << Lookout::Results::Failures::Behavior.new(nil, 0, nil)
    results << Lookout::Results::Fulfilled.new(nil, 0)
  end

  expect Lookout::Results.new.to.have.succeeded? do |results|
    results << Lookout::Results::Fulfilled.new(nil, 0)
    results << Lookout::Results::Fulfilled.new(nil, 0)
  end
end
