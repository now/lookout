# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Reception::Arguments::None.new =~ []
  end

  expect false do
    Lookout::Reception::Arguments::None.new =~ [1, 2, 3]
  end

  expect '' do
    Lookout::Reception::Arguments::None.new.to_s
  end
end
