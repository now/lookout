# -*- coding: utf-8 -*-

Expectations do
  expect 'stub' do
    Lookout::Stub::Object.new.inspect
  end

  expect Lookout::Stub::Object.new do |o|
    o.any_old_method
  end

  expect Lookout::Stub::Object.new do |o|
    o.any_old_method_with_various_arguments(1, [], {})
  end

  expect Lookout::Stub::Object.new do |o|
    o.any_old_method_with_a_block{ }
  end
end
