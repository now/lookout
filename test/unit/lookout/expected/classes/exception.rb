# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Classes::Exception do
    RuntimeError.to_lookout_expected.actualize('test', 1)
  end
end
