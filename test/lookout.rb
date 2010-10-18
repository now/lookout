# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Runners::Console.to.receive.suite_eval do |suite|
    Expectations{ }
  end
end
