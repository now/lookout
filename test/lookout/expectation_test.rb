# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Results::StateBasedFailure do
    Lookout::Expectation.new(1, nil, nil) { 2 }.execute
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.new(1, nil, nil) { 1 }.execute
  end

  expect Lookout::Results::Error do
    Lookout::Expectation.new(1, nil, nil) { raise }.execute
  end

  expect "undefined method `no_method' for Object:Class" do
    Lookout::Expectation.new(ArgumentError, nil, nil) { Object.no_method }.execute.exception.to_s
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.new(NoMethodError, nil, nil) { Object.no_method }.execute
  end

  expect nil do
    Lookout::Expectation.new(String, nil, nil) { Object.no_method }.execute.actual
  end

  Lookout::Expectation.new(nil, nil, nil).to.delegate(:ignore).to(:stub_everything) do |o|
    o.ignore
  end

  expect Lookout::Recorders::State do
    ''.to.have.to_s == ''
  end

  expect Lookout::Results::StateBasedFailure do
    Lookout::Expectation.new('foo'.to.have.to_s == 'bar', nil, nil).execute
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.new('foo'.to.have.to_s == 'foo', nil, nil).execute
  end
end
