# -*- coding: utf-8 -*-

Expectations do
  expect true do
    [1].one?
  end

  expect false do
    [1].one?{ false }
  end

  expect nil do
    Lookout::State::Have.new([1]).one?.to_lookout_expected.difference(:unused)
  end

  expect Lookout::Difference::Lookout::State.new('expected [1] to have one? { … }') do
    Lookout::State::Have.new([1]).one?{ false }.to_lookout_expected.difference(:unused)
  end
end
