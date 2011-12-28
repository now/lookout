# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Mock::Method::Arguments::List.new(1, Object, 3) =~ [1, 2, 3]
  end

  expect false do
    Lookout::Mock::Method::Arguments::List.new(1, 4, 3) =~ [1, 2, 3]
  end

  expect '1, 2, 3' do
    Lookout::Mock::Method::Arguments::List.new(1, 2, 3).inspect
  end

  expect '1, (cannot inspect argument: error), 3' do
    Lookout::Mock::Method::Arguments::List.new(1, stub(:inspect => proc{ raise 'error' } ), 3).inspect
  end

  expect [1, 2, 3] do
    Lookout::Mock::Method::Arguments::List.new(1, 2, 3).to_a
  end
end
