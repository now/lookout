# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new(nil, 0).not.to.be.error?
  expect Lookout::Results::Fulfilled.new(nil, 0).not.to.be.failure?
  expect Lookout::Results::Fulfilled.new(nil, 0).to.be.fulfilled?
end
