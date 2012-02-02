# -*- coding: utf-8 -*-

Expectations do
  expect false do
    {'a' => 1}.to_lookout_expected =~ 'b'
  end

  expect false do
    {'a' => 1, 'b' => 2}.to_lookout_expected =~ {'a' => 1}
  end

  expect false do
    {'a' => 1, 'b' => 2}.to_lookout_expected =~ {'a' => 1, 'b' => 3}
  end

  expect true do
    {'a' => 1, 'b' => 2}.to_lookout_expected =~ {'a' => 1, 'b' => 2}
  end

  expect true do
    {'a' => Integer, 'b' => 2}.to_lookout_expected =~ {'a' => 1, 'b' => 2}
  end
end
