# -*- coding: utf-8 -*-

Expectations do
  expect false do
    Lookout::Runners::Trackers::Failure.new(Lookout::Results.new).failed?
  end

  expect true do
    results = Lookout::Results.new
    failed = Lookout::Runners::Trackers::Failure.new(results)
    results << Lookout::Results::Failures::State.new(nil, 0, nil)
    failed.failed?
  end

  expect true do
    results = Lookout::Results.new
    failed = Lookout::Runners::Trackers::Failure.new(results)
    results << Lookout::Results::Failures::State.new(nil, 0, nil)
    results << Lookout::Results::Fulfilled.new(nil, 0)
    failed.failed?
  end

  expect true do
    results = Lookout::Results.new
    failed = Lookout::Runners::Trackers::Failure.new(results)
    results << Lookout::Results::Fulfilled.new(nil, 0)
    results << Lookout::Results::Failures::State.new(nil, 0, nil)
    failed.failed?
  end
end
