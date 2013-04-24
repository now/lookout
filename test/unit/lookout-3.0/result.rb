# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Results::Success.new('a', 1) == Lookout::Results::Success.new('a', 1)
  end

  expect false do
    Lookout::Results::Success.new('a', 1) == Lookout::Results::Success.new('a', 2)
  end

  expect false do
    Lookout::Results::Success.new('a', 1) == Lookout::Results::Success.new('b', 1)
  end

  expect 'test:1' do
    Lookout::Results::Success.new('test', 1).to_s
  end

  expect 'test' do
    Lookout::Results::Success.new('test', 1).file
  end

  expect 1 do
    Lookout::Results::Success.new('test', 1).line
  end
end
