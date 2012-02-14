# -*- coding: utf-8 -*-

Expectations do
  expect ArgumentError.new('wrong number of arguments (1 for 0): stub(…).a(1){ … } should be stub(…).a{ … }') do
    Lookout::Expect::Object::Context::Stub.new(Lookout::Stub::Methods.new, Object.new).a(1){ 1 }
  end
end
