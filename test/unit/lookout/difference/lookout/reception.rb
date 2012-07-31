# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Reception.
          new(0, Lookout::Reception.of(stub, :call).once)) do
    Lookout::Reception.of(stub, :call).once.to_lookout_expected.expect('test', 1).call
  end
end
