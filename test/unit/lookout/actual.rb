# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Actual::Not do
    Lookout::Actual.new.not
  end

  expect Lookout::Actual.new do |o|
    o.to
  end

  expect Lookout::Actual.new do |o|
    o.to.be
  end

  expect Lookout::Actual.new do |o|
    o.to.have
  end

  expect Lookout::Actual.new do |o|
    o.to.be.empty?
  end

  expect Lookout::Expected::Lookout::Actual.new(Lookout::Actual::Methods.new.push(:empty?)) do |o|
    Lookout::Actual.new.to.be.empty?.to_lookout_expected
  end
end
