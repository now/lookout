# -*- coding: utf-8 -*-

Expectations do
  expect 0 do
    Lookout::Actual::Methods::Method::new(:length).call([])
  end

  expect '#length' do
    Lookout::Actual::Methods::Method::new(:length).to_s
  end

  expect '#==(0)' do
    Lookout::Actual::Methods::Method::new(:==, 0).to_s
  end

  expect '#one?{ … }' do
    Lookout::Actual::Methods::Method::new(:one?){ true }.to_s
  end

  expect '#one?(1){ … }' do
    Lookout::Actual::Methods::Method::new(:one?, 1){ true }.to_s
  end

  expect '#push(1, 2, 3)' do
    Lookout::Actual::Methods::Method::new(:push, 1, 2, 3).to_s
  end
end
