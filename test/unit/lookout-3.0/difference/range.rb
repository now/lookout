# -*- coding: utf-8 -*-

Expectations do
  expect '0..2≠0..1' do
    (0..1).to_lookout_expected.difference((0..2)).message
  end

  expect '2∉0..1' do
    (0..1).to_lookout_expected.difference(2).message
  end
end
