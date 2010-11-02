# -*- coding: utf-8 -*-

Expectations do
  expect Object.new.extend(Lookout::Results::Error).to.be.error?
  expect Object.new.extend(Lookout::Results::Error).not.to.be.failure?
  expect Object.new.extend(Lookout::Results::Error).not.to.be.fulfilled?
end
