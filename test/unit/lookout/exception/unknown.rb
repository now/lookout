# -*- coding: utf-8 -*-

Expectations do
  expect RuntimeError.new('cannot determine class of exception: inner') do
    Lookout::Exception::Unknown.new(RuntimeError.new('inner')).name
  end

  expect RuntimeError.new('cannot determine class of exception: cannot retrieve error message: inner') do
    stub(RuntimeError.new, :message => proc{ raise 'inner' }){ |exception|
      Lookout::Exception::Unknown.new(exception).name
    }
  end

  expect '(cannot determine class of exception: inner)' do
    Lookout::Exception::Unknown.new(RuntimeError.new('inner')).inspect
  end

  expect '(cannot determine class of exception: cannot retrieve error message: inner)' do
    stub(RuntimeError.new, :message => proc{ raise 'inner' }){ |exception|
      Lookout::Exception::Unknown.new(exception).inspect
    }
  end
end
