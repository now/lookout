# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    String.to_lookout_expected.difference('a')
  end

  expect Lookout::Difference::Module do
    String.to_lookout_expected.difference(1)
  end

  expect nil do
    String.to_lookout_expected.difference(String)
  end

  expect Lookout::Difference::Module do
    String.to_lookout_expected.difference(Integer)
  end

  expect nil do
    Module.to_lookout_expected.difference(String)
  end
end
