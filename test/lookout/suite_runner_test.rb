# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect mock.to.receive(:instance_eval) do |suite|
    Lookout::Runners::Console.stubs(:instance).returns stub(:suite => suite)
    Lookout::Runners::Console.suite_eval {}
  end

  expect mock.to.receive(:do_not_run) do |suite|
    Lookout::Runners::Console.stubs(:instance).returns stub(:suite => suite)
    Lookout::Runners::Console.do_not_run
  end
end
