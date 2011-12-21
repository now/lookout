# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Warning do
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

  expect Lookout::Results::Failures::State.new('test', 1, 'warning("b")≠warning("a"): [-b-]{+a+}') do
    Lookout::Warning.new('a').to_lookout_expected.actualize('test', 1){
      warn 'b'
    }.call
  end

  expect Lookout::Results::Failures::State.
    new('test', 1,
        'warning("%s:%d: warning: b")≠warning("a"): [-b-]{+a+}' % [__FILE__, __LINE__ + 2]) do
    Lookout::Warning.new('a').to_lookout_expected.actualize('test', 1){
      warn '%s:%d: warning: b' % [__FILE__, __LINE__]
    }.call
  end
end
