# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Classes::Exception do
    RuntimeError.to_lookout_expected.expect('test', 1)
  end
end
