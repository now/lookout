# -*- coding: utf-8 -*-

Expectations do
  expect RuntimeError.
    new('can only mock one method per expectation: mock either stub.a(*args, &block) or stub.b(*args, &block)') do
    methods = Lookout::Mock::Methods.new
    begin
      methods.define(stub, :a, Lookout::Mock::Method::Calls::Lower.new(:a, 1))
      methods.define(stub, :b, Lookout::Mock::Method::Calls::Lower.new(:b, 1))
    ensure
      methods.undefine
    end
  end
end
