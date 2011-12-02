# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::State::Output.new(Lookout::Output.new('a'), 'test', 1){ |io|
      io.write('a')
    }.evaluate
  end

  expect Lookout::Results::Failures::State.new('test', 1, 'output("b")≠output("a"): [-b-]{+a+}') do
    Lookout::Expectations::State::Output.new(Lookout::Output.new('a'), 'test', 1){ |io|
      io.write('b')
    }.evaluate
  end
end
