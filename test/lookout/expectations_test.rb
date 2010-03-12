# -*- coding: utf-8 -*-

require File.dirname(__FILE__) + "/../test_helper"

Expectations do

  expect Lookout::Runners::Console.to.receive(:suite_eval) do |suite|
    Expectations {  }
  end

  expect Lookout::Runners::Console.to.receive(:do_not_run) do |suite|
    Expectations { Object.no_method_error_should_raise } rescue nil
  end

end
