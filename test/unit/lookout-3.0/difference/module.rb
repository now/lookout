# -*- coding: utf-8 -*-

Expectations do
  expect 'Module≠Enumerable' do
    Enumerable.to_lookout_expected.difference(Module).message
  end

  expect '1≉Enumerable' do
    Enumerable.to_lookout_expected.difference(1).message
  end
end
