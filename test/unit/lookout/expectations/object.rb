# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::Object.new(Lookout::Expected::Object.new(2), 'test', 1){ 2 }.evaluate
  end

  expect Lookout::Results::Error do
    Lookout::Expectations::Object.new(Lookout::Expected::Object.new(stub(:== => proc{ raise })), 'test', 1){ 2 }.evaluate
  end

  expect Lookout::Results::Failures::State.new('test', 1, '3≠2') do
    Lookout::Expectations::Object.new(Lookout::Expected::Object.new(2), 'test', 1){ 3 }.evaluate
  end
end
