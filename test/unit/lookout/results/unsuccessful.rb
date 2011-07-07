# -*- coding: utf-8 -*-

Expectations do
  expect 0 do
    results = Lookout::Results::Unsuccessful.new
    results << Lookout::Results::Fulfilled.new(nil, 0)
    results.count
  end

  expect Lookout::Results::Unsuccessful.new.not.to.have.succeeded? do |results|
    results << Lookout::Results::Failures::State.new(nil, 0, nil)
    results << Lookout::Results::Fulfilled.new(nil, 0)
  end

  expect Lookout::Results::Unsuccessful.new.not.to.have.succeeded? do |results|
    results << Lookout::Results::Failures::Behavior.new(nil, 0, nil)
    results << Lookout::Results::Fulfilled.new(nil, 0)
  end

  expect Lookout::Results::Unsuccessful.new.to.have.succeeded? do |results|
    results << Lookout::Results::Fulfilled.new(nil, 0)
    results << Lookout::Results::Fulfilled.new(nil, 0)
  end
end
