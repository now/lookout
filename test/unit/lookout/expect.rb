# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Exception do
    Lookout::Expect.actualize(StandardError.new, 'test', 1)
  end

  expect NoMethodError do
    Lookout::Aphonic.new.to_lookout_expected
  end

  expect Lookout::Expect::Object do
    Lookout::Expect.actualize(Lookout::Aphonic.new, 'test', 1)
  end

  expect RuntimeError do
    raise 'this StandardError expectation is needed due to a problem in Ruby 1.9.3p0 and NoMethodError'
  end
end
