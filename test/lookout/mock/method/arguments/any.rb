# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Mock::Method::Arguments::Any.new == []
  end

  expect true do
    Lookout::Mock::Method::Arguments::Any.new == [1, 2, 3]
  end
end
