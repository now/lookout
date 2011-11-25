# -*- coding: utf-8 -*-

Expectations do
  expect RuntimeError.
    new('can only mock one method per expectation: mock either stub.a(*args, &block) or stub.b(*args, &block)') do
    methods = Lookout::Mock::Methods.new
    begin
      methods.define(stub, :a)
      methods.define(stub, :b)
    ensure
      methods.undefine
    end
  end
end
