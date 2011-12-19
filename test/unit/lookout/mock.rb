# -*- coding: utf-8 -*-

Expectations do
  expect 1 do
    stub(:method => 1).method
  end

  expect 2 do
    s = stub(:method => 1)
    Lookout::Mock.methods do |mocks|
      mocks.define(s, :method, *[], proc{ 2 }){ }
      s.method
    end
  end

  expect NoMethodError do
    s = Object.new
    Lookout::Mock.methods do |mocks|
      mocks.define(s, :a, *[], proc{ 2 }){ }
    end
    s.a
  end

  expect 1 do
    s = stub(:method => 1)
    Lookout::Mock.methods do |mocks|
      mocks.define(s, :method, *[], proc{ 2 }){ }
    end
    s.method
  end
end
