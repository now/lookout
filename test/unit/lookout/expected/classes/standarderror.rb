# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Classes::StandardError do
    RuntimeError.to_lookout_expected.to_lookout_expectation('test', 1)
  end
end