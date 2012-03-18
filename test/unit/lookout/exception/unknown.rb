# -*- coding: utf-8 -*-

Expectations do
  expect RuntimeError.new('cannot determine class of exception: inner') do
    Lookout::Exception::Unknown.new(RuntimeError.new('inner')).name
  end

  expect RuntimeError.new('cannot determine class of exception: cannot retrieve error message: inner') do
    Lookout::Exception::Unknown.new(stub(RuntimeError.new).message{ raise 'inner' }).name
  end

  expect '(cannot determine class of exception: inner)' do
    Lookout::Exception::Unknown.new(RuntimeError.new('inner')).inspect
  end

  expect '(cannot determine class of exception: cannot retrieve error message: inner)' do
    Lookout::Exception::Unknown.new(stub(RuntimeError.new).message{ raise 'inner' }).inspect
  end
end
