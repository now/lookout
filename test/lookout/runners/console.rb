# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Suite.not.to.receive.new do
    Lookout::Runners::Console.suite_eval{ }
  end
end
