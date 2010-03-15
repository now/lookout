# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do
  expect Lookout::Results::StateBasedFailure do
    suite = Lookout::Suite.new
    suite.expect(3) == 4
    suite.execute(Lookout::UI::Silent)
    suite.expectations.first
  end

  expect Lookout::Results::Fulfilled do
    suite = Lookout::Suite.new
    suite.expect(3) == 3
    suite.execute(Lookout::UI::Silent)
    suite.expectations.first
  end

  expect Lookout::Results::Fulfilled do
    suite = Lookout::Suite.new
    suite.expect('foo bar') =~ /foo/
    suite.execute(Lookout::UI::Silent)
    suite.expectations.first
  end

  expect Lookout::Results::StateBasedFailure do
    suite = Lookout::Suite.new
    suite.expect('bar') =~ /foo/
    suite.execute(Lookout::UI::Silent)
    suite.expectations.first
  end
end
