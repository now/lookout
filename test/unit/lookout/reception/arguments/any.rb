# -*- coding: utf-8 -*-

Expectations do
  expect '*args, &block' do
    Lookout::Reception::Arguments::Any.new.to_s
  end

  expect true do
    Lookout::Reception::Arguments::Any.new =~ []
  end

  expect true do
    Lookout::Reception::Arguments::Any.new =~ [1, 2, 3]
  end
end
