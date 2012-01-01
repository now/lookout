# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Output do
    Lookout::Output.new('a').to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Results::Success.new('test', 1) do
    Lookout::Output.new('a').to_lookout_expected.actualize('test', 1){ |io|
      io.write('a')
    }.call
  end

  expect Lookout::Results::Failure.new('test', 1, 'output("b")≠output("a"): [-b-]{+a+}') do
    Lookout::Output.new('a').to_lookout_expected.actualize('test', 1){ |io|
      io.write('b')
    }.call
  end
end
