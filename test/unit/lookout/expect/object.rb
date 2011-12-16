# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expect::Object.new(Lookout::Expected::Object.new(2), 'test', 1){ 2 }.call
  end

  expect Lookout::Results::Error do
    Lookout::Expect::Object.new(Lookout::Expected::Object.new(stub(:== => proc{ raise })), 'test', 1){ 2 }.call
  end

  expect Lookout::Results::Failures::State.new('test', 1, '3≠2') do
    Lookout::Expect::Object.new(Lookout::Expected::Object.new(2), 'test', 1){ 3 }.call
  end
end
