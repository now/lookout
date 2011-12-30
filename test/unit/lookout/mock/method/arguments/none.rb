# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Mock::Method::Arguments::None.new =~ []
  end

  expect false do
    Lookout::Mock::Method::Arguments::None.new =~ [1, 2, 3]
  end

  expect '' do
    Lookout::Mock::Method::Arguments::None.new.to_s
  end

  expect [Lookout::Mock::Method::Arguments::None] do
    Lookout::Mock::Method::Arguments::None.new.to_a
  end
end
