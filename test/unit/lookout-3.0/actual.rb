# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Actual::Not do Lookout::Actual.new.not end

  expect Lookout::Actual do Lookout::Actual.new.to end

  expect Lookout::Actual do Lookout::Actual.new.to.be end

  expect Lookout::Actual do Lookout::Actual.new.to.have end

  expect Lookout::Actual::Method do Lookout::Actual.new.to.be.empty? end
end
