# -*- coding: utf-8 -*-

Expectations do
  expect true do
    [1].one?
  end

  expect false do
    [1].one?{ false }
  end

  expect true do
    Lookout::Recorders::State::Have.new([1]).one?.subject!(nil).last.call
  end

  expect Lookout::Recorders::State::Error.new('expected [1] to have one? { … }') do
    Lookout::Recorders::State::Have.new([1]).one?{ false }.subject!(nil).last.call
  end
end
