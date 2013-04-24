# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    true.to_lookout_expected.difference(true)
  end

  expect Lookout::Difference::Object do
    true.to_lookout_expected.difference(false)
  end

  expect Lookout::Difference::Object do
    true.to_lookout_expected.difference(nil)
  end

  expect nil do
    true.to_lookout_expected.difference(1)
  end

  expect nil do
    true.to_lookout_expected.difference(stub(:== => proc{ raise 'error' }))
  end
end
