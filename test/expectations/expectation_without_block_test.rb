# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do
  expect Expectations::Results::StateBasedFailure do
    suite = Expectations::Suite.new
    suite.expect(3) == 4
    suite.execute(Silent)
    suite.expectations.first
  end

  expect Expectations::Results::Fulfilled do
    suite = Expectations::Suite.new
    suite.expect(3) == 3
    suite.execute(Silent)
    suite.expectations.first
  end

  expect Expectations::Results::Fulfilled do
    suite = Expectations::Suite.new
    suite.expect('foo bar') =~ /foo/
    suite.execute(Silent)
    suite.expectations.first
  end

  expect Expectations::Results::StateBasedFailure do
    suite = Expectations::Suite.new
    suite.expect('bar') =~ /foo/
    suite.execute(Silent)
    suite.expectations.first
  end
end
