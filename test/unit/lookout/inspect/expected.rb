# -*- coding: utf-8 -*-

Expectations do
  expect '(cannot inspect expected value: error)' do
    Lookout::Inspect::Expected.new(stub(:inspect => proc{ raise 'error' })).call
  end
end
