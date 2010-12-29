# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Error.new(nil, 0, nil, nil).to.be.error?
  expect Lookout::Results::Error.new(nil, 0, nil, nil).not.to.be.failure?
  expect Lookout::Results::Error.new(nil, 0, nil, nil).not.to.be.fulfilled?
end
