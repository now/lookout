# -*- coding: utf-8 -*-

Expectations do
  expect RuntimeError.
    new('can only mock one method per expectation: mock either stub.a(*args, &block) or stub.b(*args, &block)') do
    methods = Lookout::Mock::Methods.new
    begin
      methods.define(stub, :a, *[], proc{ }){ }
      methods.define(stub, :b, *[], proc{ }){ }
    ensure
      methods.undefine
    end
  end
end
