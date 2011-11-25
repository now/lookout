# -*- coding: utf-8 -*-

Expectations do
  expect 'mock' do
    Lookout::Mock::Object.new.inspect
  end

  expect Lookout::Mock::Method::Calls::Error.new('unexpected call to mock.any_old_method(*args, &block)') do
    Lookout::Mock::Object.new.any_old_method
  end

  expect Lookout::Mock::Method::Calls::Error.new('unexpected call to mock.any_old_method(1)') do
    Lookout::Mock::Object.new.any_old_method 1
  end
end
