# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Reception::Arguments::Any do
    Lookout::Reception::Arguments.for
  end

  expect Lookout::Reception::Arguments::Any do
    Lookout::Reception::Arguments.for(1, Lookout::Reception::Arguments::Any.new)
  end

  expect Lookout::Reception::Arguments::None do
    Lookout::Reception::Arguments.for(Lookout::Reception::Arguments::None.new)
  end

  expect Lookout::Reception::Arguments::None do
    Lookout::Reception::Arguments.for(1, Lookout::Reception::Arguments::None.new)
  end

  expect Lookout::Reception::Arguments::List.new(1, 2, 3) do
    Lookout::Reception::Arguments.for(1, 2, 3)
  end
end
