# -*- coding: utf-8 -*-

Expectations do
  expect 1 do
    stub(:method => 1).method
  end

  expect 2 do
    s = stub(:method => 1)
    Lookout::Stub.methods do |stubs|
      stubs.define(s, :method){ 2 }
      s.method
    end
  end

  expect 1 do
    s = stub(:method => 1)
    Lookout::Stub.methods do |stubs|
      stubs.define(s, :method){ 2 }
    end
    s.method
  end

  expect NoMethodError do
    s = Object.new
    Lookout::Stub.methods do |stubs|
      stubs.define(s, :a){ 2 }
    end
    s.a
  end

  expect 4 do
    s = stub(:a => 1)
    Lookout::Stub.methods do |stubs|
      stubs.define(s, :a){ 2 }
      stubs.define(s, :b){ 2 }
      s.a + s.b
    end
  end
end
