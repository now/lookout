# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Results::Failure.new('a', 1, nil) == Lookout::Results::Failure.new('a', 1, nil)
  end

  expect true do
    Lookout::Results::Failure.new('a', 1, 'b') == Lookout::Results::Failure.new('a', 1, 'b')
  end

  expect false do
    Lookout::Results::Failure.new('a', 1, nil) == Lookout::Results::Failure.new('a', 1, 'b')
  end

  expect "test:1" do
    Lookout::Results::Failure.new('test', 1, nil).to_s
  end

  expect "test:1: a≠b" do
    Lookout::Results::Failure.new('test', 1, 'a≠b').to_s
  end

  expect 'a≠b' do
    Lookout::Results::Failure.new('test', 1, 'a≠b').message
  end
end
