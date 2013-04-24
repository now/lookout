# -*- coding: utf-8 -*-

Expectations do
  expect 0 do
    Lookout::Actual::Method::new(:length).call([])
  end

  expect '#length' do
    Lookout::Actual::Method::new(:length).to_s
  end

  expect '#==(0)' do
    Lookout::Actual::Method::new(:==, 0).to_s
  end

  expect '#one?{ … }' do
    Lookout::Actual::Method::new(:one?){ true }.to_s
  end

  expect '#one?(1){ … }' do
    Lookout::Actual::Method::new(:one?, 1){ true }.to_s
  end

  expect '#push(1, 2, 3)' do
    Lookout::Actual::Method::new(:push, 1, 2, 3).to_s
  end

  expect Lookout::Expected::Lookout::Actual::Method.new(Lookout::Actual::Method.new(:empty?)) do |o|
    Lookout::Actual.new.to.be.empty?.to_lookout_expected
  end
end
