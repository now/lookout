# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Suite.not.to.receive.new do
    Lookout::Runners::Console.suite_eval{ }
  end
end
