# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Reception do
    Object.new.to.receive.call.to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Expected::Reception do
    Object.new.to.receive.call.to_lookout_expected.mock(Lookout::Mock::Methods.new)
  end

  expect 1 do
    o = Object.new
    o.to.receive.call{ 1 }.to_lookout_expected.mock(Lookout::Mock::Methods.new)
    o.call
  end
end
