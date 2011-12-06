# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::Warning.new(Lookout::Expected::Warning.new(Lookout::Warning.new('a')), 'test', 1){ |io|
      warn 'a'
    }.evaluate
  end

  expect Lookout::Results::Fulfilled.new('test', 1) do
    Lookout::Expectations::Warning.new(Lookout::Expected::Warning.new(Lookout::Warning.new('a')), 'test', 1){ |io|
      warn '%s:%d: warning: a' % [__FILE__, __LINE__]
    }.evaluate
  end

  expect Lookout::Results::Failures::State.new('test', 1, 'warning("b")≠warning("a"): [-b-]{+a+}') do
    Lookout::Expectations::Warning.new(Lookout::Expected::Warning.new(Lookout::Warning.new('a')), 'test', 1){ |io|
      warn 'b'
    }.evaluate
  end

  expect Lookout::Results::Failures::State.
    new('test', 1,
        'warning("%s:%d: warning: b")≠warning("a"): [-b-]{+a+}' % [__FILE__, __LINE__ + 2]) do
    Lookout::Expectations::Warning.new(Lookout::Expected::Warning.new(Lookout::Warning.new('a')), 'test', 1){ |io|
      warn '%s:%d: warning: b' % [__FILE__, __LINE__]
    }.evaluate
  end
end
