# -*- coding: utf-8 -*-

Expectations do
  expect 1 do
    results = Lookout::Expectations::Results.new
    results << Object.new.extend(Lookout::Results::Fulfilled)
    results.fulfillments.size
  end

  expect 0 do
    results = Lookout::Expectations::Results.new
    results << Object.new.extend(Lookout::Results::Fulfilled)
    results.errors.size
  end

  expect Lookout::Expectations::Results.new.not.to.have.succeeded? do |results|
    results << Object.new.extend(Lookout::Results::Failures::State)
    results << Object.new.extend(Lookout::Results::Fulfilled)
  end

  expect Lookout::Expectations::Results.new.not.to.have.succeeded? do |results|
    results << Object.new.extend(Lookout::Results::Failures::Behavior)
    results << Object.new.extend(Lookout::Results::Fulfilled)
  end

  expect Lookout::Expectations::Results.new.to.have.succeeded? do |results|
    results << Object.new.extend(Lookout::Results::Fulfilled)
    results << Object.new.extend(Lookout::Results::Fulfilled)
  end
end
