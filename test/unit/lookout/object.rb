# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new(/expected .* to be nil?/) do
    true.to.be.nil?.verify
  end

  expect nil.to.be.nil?.verify

  expect Lookout::Recorders::State::Error.new(/expected .* not to be nil?/) do
    nil.not.to.be.nil?.verify
  end

  expect true.not.to.be.nil?.verify
end
