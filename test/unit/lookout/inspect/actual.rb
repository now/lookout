# -*- coding: utf-8 -*-

Expectations do
  expect '(cannot inspect actual result: error)' do
    Lookout::Inspect::Actual.new(stub(:inspect => proc{ raise 'error' })).call
  end
end
