# -*- coding: utf-8 -*-

Expectations do
  expect RuntimeError.
    new('can only mock one method per expectation: mock either stub.a(*args, &block) or stub.b(*args, &block)') do
    Lookout::Mock::Methods.during do |methods|
      methods.define(stub, :a, Lookout::Mock::Method::Calls::Lower.new(:a, 1))
      methods.define(stub, :b, Lookout::Mock::Method::Calls::Lower.new(:b, 1))
    end
  end

  expect 1 do
    stub(:a => 1).a
  end

  expect 2 do
    s = stub(:a => 1)
    Lookout::Mock::Methods.during do |methods|
      methods.define(s, :a, Lookout::Mock::Method::Calls::Lower.new(:method, 1)){ 2 }
      s.a
    end
  end

  expect NoMethodError do
    s = Object.new
    Lookout::Mock::Methods.during do |methods|
      methods.define(s, :a, Lookout::Mock::Method::Calls::Lower.new(:a, 1)){ 2 }
    end
    s.a
  end

  expect 1 do
    s = stub(:a => 1)
    Lookout::Mock::Methods.during do |methods|
      methods.define(s, :a, Lookout::Mock::Method::Calls::Lower.new(:a, 1)){ 2 }
    end
    s.a
  end
end
