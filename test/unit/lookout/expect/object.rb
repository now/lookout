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

  expect nil do
    2.to_lookout_expected.actualize('test', 1) <=> 2
  end

  expect 0 do
    2.to_lookout_expected.actualize('test', 1) <=> 2.to_lookout_expected.actualize('test', 1)
  end

  expect true do
    (2.to_lookout_expected.actualize('test', 1) <=> 2.to_lookout_expected.actualize('test', 2)) < 0
  end

  expect false do
    (2.to_lookout_expected.actualize('test', 1) <=> 2.to_lookout_expected.actualize('test', 0)) < 0
  end

  expect false do
    (2.to_lookout_expected.actualize('test', 1) <=> 2.to_lookout_expected.actualize('test', 2)) > 0
  end

  expect true do
    (2.to_lookout_expected.actualize('test', 1) <=> 2.to_lookout_expected.actualize('test', 0)) > 0
  end
end
