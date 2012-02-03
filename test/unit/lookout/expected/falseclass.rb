# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Object do
    false.to_lookout_expected.difference(true)
  end

  expect nil do
    false.to_lookout_expected.difference(false)
  end

  expect nil do
    false.to_lookout_expected.difference(nil)
  end

  expect Lookout::Difference::Object do
    false.to_lookout_expected.difference(1)
  end

  expect Lookout::Difference::Object do
    false.to_lookout_expected.difference(stub(:== => proc{ raise 'error' }))
  end
end
