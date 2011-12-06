# -*- coding: utf-8 -*-

Expectations do
  expect true do
    true.to_lookout_expected =~ true
  end

  expect false do
    true.to_lookout_expected =~ false
  end

  expect false do
    false.to_lookout_expected =~ true
  end

  expect true do
    false.to_lookout_expected =~ false
  end

  expect false do
    true.to_lookout_expected =~ nil
  end

  expect true do
    true.to_lookout_expected =~ 1
  end

  expect true do
    false.to_lookout_expected =~ nil
  end

  expect false do
    false.to_lookout_expected =~ 1
  end

  expect true do
    true.to_lookout_expected =~ stub(:== => proc{ raise 'error' })
  end

  expect false do
    false.to_lookout_expected =~ stub(:== => proc{ raise 'error' })
  end
end
