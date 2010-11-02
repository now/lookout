# -*- coding: utf-8 -*-

Expectations do
  expect Object.new.extend(Lookout::Results::Fulfilled).not.to.be.error?
  expect Object.new.extend(Lookout::Results::Fulfilled).not.to.be.failure?
  expect Object.new.extend(Lookout::Results::Fulfilled).to.be.fulfilled?
end
