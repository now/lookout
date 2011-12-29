# -*- coding: utf-8 -*-

Expectations do
  expect RuntimeError.
    new('can only mock one method per expectation: mock either stub.a(*args, &block) or stub.b(*args, &block)') do
    Lookout::Mock::Methods.
      new.
      define(stub, :a, Lookout::Mock::Method::Calls::Lower.new(stub, :a, 1)).
      define(stub, :b, Lookout::Mock::Method::Calls::Lower.new(stub, :a, 1))
  end

  expect 1 do
    stub(:a => 1).a
  end

  expect 2 do
    s = stub(:a => 1)
    Lookout::Mock::Methods.with_verification do |methods|
      methods.define(s, :a, Lookout::Mock::Method::Calls::Lower.new(s, :a, 1)){ 2 }
      s.a
    end
  end

  expect NoMethodError do
    Object.new.a
  end

  expect NoMethodError do
    s = Object.new
    Lookout::Mock::Methods.with_verification do |methods|
      methods.define(s, :a, Lookout::Mock::Method::Calls::Exactly.new(s, :a, 0)){ 2 }
    end
    s.a
  end

  expect 1 do
    s = stub(:a => 1)
    Lookout::Mock::Methods.with_verification do |methods|
      methods.define(s, :a, Lookout::Mock::Method::Calls::Exactly.new(s, :a, 0)){ 2 }
    end
    s.a
  end

  expect Lookout::Mock::Method::Calls::Error do
    s = stub(:a => 1)
    Lookout::Mock::Methods.with_verification do |methods|
      methods.define(s, :a, Lookout::Mock::Method::Calls::Lower.new(s, :a, 1)){ 2 }
    end
  end
end
