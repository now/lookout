# -*- coding: utf-8 -*-

Expectations do
  expect true do
    [1].one?
  end

  expect false do
    [1].one?{ false }
  end

  expect true do
    Lookout::State::Have.new([1]).one?.to_lookout_expected.verify
  end

  expect Lookout::State::Error.new('expected [1] to have one? { … }') do
    Lookout::State::Have.new([1]).one?{ false }.to_lookout_expected.verify
  end
end
