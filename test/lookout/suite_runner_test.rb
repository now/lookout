# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Suite.to.receive(:new).never do
    Lookout::Runners::Console.suite_eval{ }
  end

  expect Lookout::Suite.any_instance.to.receive(:instance_eval) do
    Lookout::Runners::Console.suite_eval{ }
  end
end
