# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Lookout::Reception do
    'a'.to.receive.call.once.to_lookout_expected.expect('test', 1)
  end

  expect nil do
    o = 'a'
    o.to.receive.call.once.to_lookout_expected.difference(proc{ o.call })
  end

  expect Lookout::Difference::Lookout::Reception do
    o = 'a'
    o.to.receive.call.once.to_lookout_expected.difference(proc{ })
  end
end
