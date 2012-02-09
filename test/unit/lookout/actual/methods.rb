# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Actual::Methods.new do |o|
    o.push(:length)
  end

  expect true do
    Lookout::Actual::Methods.new.push(:length).push(:==, 0).call([])
  end

  expect false do
    Lookout::Actual::Methods.new.push(:length).push(:==, 1).call([])
  end

  expect false do
    Lookout::Actual::Methods.new.push(:length) == Lookout::Actual::Methods.new
  end

  expect false do
    Lookout::Actual::Methods.new.push(:length) == Lookout::Actual::Methods.new.push(:==)
  end

  expect true do
    Lookout::Actual::Methods.new.push(:length) == Lookout::Actual::Methods.new.push(:length)
  end

  expect '#length#==(0)' do
    Lookout::Actual::Methods.new.push(:length).push(:==, 0).to_s
  end

  expect '#one?{ … }' do
    Lookout::Actual::Methods.new.push(:one?){ true }.to_s
  end

  expect '#one?(1){ … }' do
    Lookout::Actual::Methods.new.push(:one?, 1){ true }.to_s
  end
end
