# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Reception do
    Object.new.to.receive.call.to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Methods.during do |methods|
      Object.new.to.receive.call.to_lookout_expected.mock(methods)
    end
  end

  expect 1 do
    Lookout::Mock::Methods.during do |methods|
      o = Object.new
      o.to.receive.call{ 1 }.to_lookout_expected.mock(methods)
      o.call
    end
  end
end
