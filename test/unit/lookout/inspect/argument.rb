# -*- coding: utf-8 -*-

Expectations do
  expect '(cannot inspect argument: error)' do
    Lookout::Inspect::Argument.new(stub(:inspect => proc{ raise 'error' })).call
  end

  expect '1, (cannot inspect argument: error), 3' do
    Lookout::Inspect::Argument.list([1, stub(:inspect => proc{ raise 'error' }), 3])
  end
end
