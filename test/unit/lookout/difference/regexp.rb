# -*- coding: utf-8 -*-

Expectations do
  expect '/b/≠/a/' do
    /a/.to_lookout_expected.difference(/b/).message
  end

  expect '"b"≉/a/' do
    /a/.to_lookout_expected.difference('b').message
  end
end
