# -*- coding: utf-8 -*-

Expectations do
  expect 'stub' do
    Lookout::Stub.new.inspect
  end

  expect Lookout::Stub.new do |o|
    o.any_old_method
  end

  expect Lookout::Stub.new do |o|
    o.any_old_method_with_various_arguments(1, [], {})
  end

  expect Lookout::Stub.new do |o|
    o.any_old_method_with_a_block{ }
  end

  if proc{ }.respond_to? :lambda?
    expect ArgumentError do
      Lookout::Stub.new(:a => lambda{ 1 }).a(2)
    end
  end

  expect 1 do
    Lookout::Stub.new(:a => proc{ 1 }).a(2)
  end

  expect 1 do
    Lookout::Stub.new(:a => proc{ 1 }).a
  end

  expect 1 do
    Lookout::Stub.new(:a => proc{ |i| i }).a(1)
  end

  expect 1 do
    Lookout::Stub.new(:a => proc{ |&b| b.call }).a{ 1 }
  end

  expect 1 do
    Lookout::Stub.new(:a => 1).a
  end

  expect 1 do
    Lookout::Stub.new(:a => 1).a(2)
  end

  expect 1 do
    Lookout::Stub.new(:a => 1).a(2){ 3 }
  end
end
