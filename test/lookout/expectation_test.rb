# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Results::Failures::State do
    Lookout::Expectation.on(1, nil, nil) { 2 }.execute
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.on(1, nil, nil) { 1 }.execute
  end

  expect Lookout::Results::Error do
    Lookout::Expectation.on(1, nil, nil) { raise }.execute
  end

  expect "undefined method `no_method' for Object:Class" do
    Lookout::Expectation.on(ArgumentError, nil, nil) { Object.no_method }.execute.exception.to_s
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.on(NoMethodError, nil, nil) { Object.no_method }.execute
  end

  expect nil do
    Lookout::Expectation.on(String, nil, nil) { Object.no_method }.execute.actual
  end

  Lookout::Expectation.on(nil, nil, nil).to.delegate(:ignore).to(:stub_everything) do |o|
    o.ignore
  end

  expect Lookout::Recorders::State do
    ''.to.have.to_s == ''
  end

  expect Lookout::Results::Failures::State do
    Lookout::Expectation.on('foo'.to.have.to_s == 'bar', nil, nil).execute
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.on('foo'.to.have.to_s == 'foo', nil, nil).execute
  end
end
