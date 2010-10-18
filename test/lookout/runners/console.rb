# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Suite.to.receive.new.never do
    Lookout::Runners::Console.suite_eval{ }
  end
end
