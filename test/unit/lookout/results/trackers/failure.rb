# -*- coding: utf-8 -*-

Expectations do
  expect false do
    Lookout::Results::Trackers::Failure.new(Lookout::Results.new).failed?
  end

  expect true do
    results = Lookout::Results.new
    failed = Lookout::Results::Trackers::Failure.new(results)
    results << Lookout::Results::Failures::State.new(nil, 0, nil)
    failed.failed?
  end

  expect true do
    results = Lookout::Results.new
    failed = Lookout::Results::Trackers::Failure.new(results)
    results << Lookout::Results::Failures::State.new(nil, 0, nil)
    results << Lookout::Results::Success.new(nil, 0)
    failed.failed?
  end

  expect true do
    results = Lookout::Results.new
    failed = Lookout::Results::Trackers::Failure.new(results)
    results << Lookout::Results::Success.new(nil, 0)
    results << Lookout::Results::Failures::State.new(nil, 0, nil)
    failed.failed?
  end
end
