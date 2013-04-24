# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Success.new('test', 1) do
    Lookout::Output.new('a').to_lookout_expected.expect('test', 1){ |io|
      io.write('a')
    }.call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Output.new(Lookout::Output.new('b'),
                                                 Lookout::Output.new('a'))) do
    Lookout::Output.new('a').to_lookout_expected.expect('test', 1){ |io|
      io.write('b')
    }.call
  end

  expect nil do
    Lookout::Output.new('a').to_lookout_expected.difference(Lookout::Output.new('a'))
  end

  expect Lookout::Difference::Lookout::Output do
    Lookout::Output.new('a').to_lookout_expected.difference(Lookout::Output.new('b'))
  end
end
