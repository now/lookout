# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Object do
    2.to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Expect::Object do
    stub.to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    2.to_lookout_expected.actualize('test', 1){ 2 }.call
  end

  expect Lookout::Results::Failures::State.new('test', 1, '3≠2') do
    2.to_lookout_expected.actualize('test', 1){ 3 }.call
  end

  expect Lookout::Results::Error do
    stub(:== => proc{ raise 'error' }).to_lookout_expected.actualize('test', 1){ 2 }.call
  end

  expect 'error (RuntimeError)' do
    stub(:== => proc{ raise 'error' }).to_lookout_expected.actualize('test', 1){ 2 }.call.exception.message
  end

  expect Comparable do
    2.to_lookout_expected.actualize('test', 1)
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
