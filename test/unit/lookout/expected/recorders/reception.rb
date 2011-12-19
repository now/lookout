# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Reception do
    Object.new.to.receive.call.to_lookout_expected.actualize('test', 1)
  end

  expect Lookout::Mock::Method do
    Lookout::Mock.methods do |mocks|
      Object.new.to.receive.call.to_lookout_expected.mock(mocks)
    end
  end

  expect 1 do
    Lookout::Mock.methods do |mocks|
      o = Object.new
      o.to.receive.call{ 1 }.to_lookout_expected.mock(mocks)
      o.call
    end
  end
end
