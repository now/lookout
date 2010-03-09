# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do
  expect Expectations::Results::StateBasedFailure do
    Expectations::Expectation.new(1, nil, nil) { 2 }.execute
  end

  expect Expectations::Results::Fulfilled do
    Expectations::Expectation.new(1, nil, nil) { 1 }.execute
  end

  expect Expectations::Results::Error do
    Expectations::Expectation.new(1, nil, nil) { raise }.execute
  end

  expect "undefined method `no_method' for Object:Class" do
    Expectations::Expectation.new(ArgumentError, nil, nil) { Object.no_method }.execute.exception.to_s
  end

  expect Expectations::Results::Fulfilled do
    Expectations::Expectation.new(NoMethodError, nil, nil) { Object.no_method }.execute
  end

  expect nil do
    Expectations::Expectation.new(String, nil, nil) { Object.no_method }.execute.actual
  end

  Expectations::Expectation.new(nil, nil, nil).to.delegate(:ignore).to(:stub_everything) do |o|
    o.ignore
  end

  expect Expectations::StateBasedRecorder do
    ''.to.have.to_s == ''
  end

  expect Expectations::Results::StateBasedFailure do
    Expectations::Expectation.new('foo'.to.have.to_s == 'bar', nil, nil).execute
  end

  expect Expectations::Results::Fulfilled do
    Expectations::Expectation.new('foo'.to.have.to_s == 'foo', nil, nil).execute
  end
end
