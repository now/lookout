# -*- coding: utf-8 -*-

Expectations do
  expect '1, (cannot inspect argument: error), 3' do
    Lookout::Mock::Method::Arguments::List.new(1, stub(:inspect => proc{ raise 'error' } ), 3).inspect
  end
end
