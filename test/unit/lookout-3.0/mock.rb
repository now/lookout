# -*- coding: utf-8 -*-

Expectations do
  expect 'mock' do
    Lookout::Mock.new.inspect
  end

  expect Lookout::Reception::Error.
    from('mock#any_old_method()', 1, 0..0) do
    Lookout::Mock.new.any_old_method
  end

  expect Lookout::Reception::Error.
    from('mock#any_old_method(1)', 1, 0..0) do
    Lookout::Mock.new.any_old_method 1
  end

  expect Lookout::Reception::Error.
    from('mock#any_old_method(1){ … }', 1, 0..0) do
    Lookout::Mock.new.any_old_method(1){ }
  end
end
