# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do
  expect mock.to.receive(:instance_eval) do |suite|
    Lookout::SuiteRunner.stubs(:instance).returns stub(:suite => suite)
    Lookout::SuiteRunner.suite_eval {}
  end

  expect mock.to.receive(:do_not_run) do |suite|
    Lookout::SuiteRunner.stubs(:instance).returns stub(:suite => suite)
    Lookout::SuiteRunner.do_not_run
  end
end
