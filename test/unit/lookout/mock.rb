# -*- coding: utf-8 -*-

Expectations do
  expect 1 do
    stub(:method => 1).method
  end

  expect 2 do
    s = stub(:a => 1)
    Lookout::Mock.methods do |mocks|
      mocks.define(s, :a, Lookout::Mock::Method::Calls::Lower.new(:method, 1)){ 2 }
      s.a
    end
  end

  expect NoMethodError do
    s = Object.new
    Lookout::Mock.methods do |mocks|
      mocks.define(s, :a, Lookout::Mock::Method::Calls::Lower.new(:a, 1)){ 2 }
    end
    s.a
  end

  expect 1 do
    s = stub(:a => 1)
    Lookout::Mock.methods do |mocks|
      mocks.define(s, :a, Lookout::Mock::Method::Calls::Lower.new(:a, 1)){ 2 }
    end
    s.a
  end
end
