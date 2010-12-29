# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Runners::Console.to.receive.expectations_eval do |suite|
    Expectations{ }
  end
end
