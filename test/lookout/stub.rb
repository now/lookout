# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect 1 do
    Object.new.tap{ |o| Lookout::Stub.stub(o).a{ 1 } }.a
  end
end
