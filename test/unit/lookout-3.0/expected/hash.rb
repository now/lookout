# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Hash do
    {'a' => 1}.to_lookout_expected.difference('b')
  end

  expect Lookout::Difference::Hash do
    {'a' => 1, 'b' => 2}.to_lookout_expected.difference({'a' => 1})
  end

  expect Lookout::Difference::Hash do
    {'a' => 1, 'b' => 2}.to_lookout_expected.difference({'a' => 1, 'b' => 3})
  end

  expect nil do
    {'a' => 1, 'b' => 2}.to_lookout_expected.difference({'a' => 1, 'b' => 2})
  end

  expect nil do
    {'a' => Integer, 'b' => 2}.to_lookout_expected.difference({'a' => 1, 'b' => 2})
  end
end
