# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Object do
    Object.new.to_lookout_expected.expect('test', 1)
  end

  expect nil do
    object = Object.new
    object.to_lookout_expected.difference(object)
  end

  expect nil do
    1.to_lookout_expected.difference(1)
  end

  expect Lookout::Difference::Object do
    Object.new.to_lookout_expected.difference(Object.new)
  end

  expect Lookout::Difference::Object do
    1.to_lookout_expected.difference(2)
  end
end
