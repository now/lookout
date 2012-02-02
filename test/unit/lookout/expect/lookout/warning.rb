# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Lookout::Warning do
    Lookout::Warning.new('a').to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Results::Success.new('test', 1) do
    Lookout::Warning.new('a').to_lookout_expected.actualize('test', 1){
      warn 'a'
    }.call
  end

  expect Lookout::Results::Success.new('test', 1) do
    Lookout::Warning.new('a').to_lookout_expected.actualize('test', 1){
      warn '%s:%d: warning: a' % [__FILE__, __LINE__]
    }.call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Warning.new(Lookout::Warning.new('b'),
                                                  Lookout::Warning.new('a'))) do
    Lookout::Warning.new('a').to_lookout_expected.actualize('test', 1){
      warn 'b'
    }.call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Warning.
          new(Lookout::Warning.new('%s:%d: warning: b' % [__FILE__, __LINE__ + 3]),
              Lookout::Warning.new('a'))) do
    Lookout::Warning.new('a').to_lookout_expected.actualize('test', 1){
      warn '%s:%d: warning: b' % [__FILE__, __LINE__]
    }.call
  end
end
