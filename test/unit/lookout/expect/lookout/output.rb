# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Lookout::Output do
    Lookout::Output.new('a').to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Results::Success.new('test', 1) do
    Lookout::Output.new('a').to_lookout_expected.actualize('test', 1){ |io|
      io.write('a')
    }.call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Output.new(Lookout::Output.new('b'),
                                                 Lookout::Output.new('a'))) do
    Lookout::Output.new('a').to_lookout_expected.actualize('test', 1){ |io|
      io.write('b')
    }.call
  end
end
