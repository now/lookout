# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Reception.
          new(0, 1..1, 'stub#call: unexpected number of invocations (0 for 1..)')) do
    Lookout::Reception.new(stub, :call).once.to_lookout_expected.expect('test', 1).call
  end
end
