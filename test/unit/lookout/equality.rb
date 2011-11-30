# -*- coding: utf-8 -*-

Expectations do
  expect RuntimeError.new('cannot determine equality relationship between nil and stub: error') do
    Lookout::Equality.equal?(stub(:== => proc{ raise 'error' }), nil)
  end

  expect RuntimeError.new('cannot determine equality relationship between nil and stub: cannot determine equality handler for stub: stub#class failed: no class for you') do
    Lookout::Equality.equal?(stub(:class => proc{ raise 'no class for you' }), nil)
  end

  expect RuntimeError.new('cannot determine equality relationship between nil and stub: cannot determine equality handler for stub: stub#class#ancestors failed: no ancestors for you') do
    Lookout::Equality.equal?(stub(:class => stub(:ancestors => proc{ raise 'no ancestors for you' })), nil)
  end

  expect RuntimeError.new('cannot determine equality relationship between nil and stub: cannot determine equality handler for stub: stub#class#ancestors#find failed: no find for you') do
    Lookout::Equality.equal?(stub(:class => stub(:ancestors => stub(:find => proc{ raise 'no find for you' }))), nil)
  end

  expect false do
    Lookout::Equality.equal?(stub(:class => stub(:ancestors => [])), nil)
  end
end
