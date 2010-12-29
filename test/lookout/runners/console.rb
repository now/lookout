# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expectations.not.to.receive.new do
    Lookout::Runners::Console.expectations_eval{ }
  end
end
