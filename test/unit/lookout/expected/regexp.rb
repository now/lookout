# -*- coding: utf-8 -*-

Expectations do
  expect true do
    /a/.to_lookout_expected =~ 'a'
  end

  expect true do
    /a/.to_lookout_expected =~ /a/
  end

  expect false do
    /a/.to_lookout_expected =~ 'b'
  end

  expect false do
    /a/.to_lookout_expected =~ /b/
  end
end