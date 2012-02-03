# -*- coding: utf-8 -*-

Expectations do
  expect '¬"a"#empty?' do
    :empty?.to_lookout_expected.difference('a').message
  end

  expect '""#empty?' do
    :not_empty?.to_lookout_expected.difference('').message
  end
end
