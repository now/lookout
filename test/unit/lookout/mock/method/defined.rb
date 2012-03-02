# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls.new(0..0)).define.undefine
  end

  expect Lookout::Mock::Method::Calls::TooManyError.
    new('stub#method: unexpected number of invocations (1 for 0)', 1, 0..0) do
    Lookout::Mock::Method::Defined.new(stub, :method, :public, nil, Lookout::Mock::Method::Calls.new(0..0)).call
  end

  expect Lookout::Mock::Method::Calls::TooManyError.
    new('Class.method: unexpected number of invocations (1 for 0)', 1, 0..0) do
    Lookout::Mock::Method::Defined.new(Class, :method, :public, nil, Lookout::Mock::Method::Calls.new(0..0)).call
  end

  expect Lookout::Mock::Method::Calls::TooManyError.
    new('(cannot inspect object: error)#method: unexpected number of invocations (1 for 0)', 1, 0..0) do
    Lookout::Mock::Method::Defined.new(stub(:inspect => proc{ raise 'error' } ),
                                       :method,
                                       :public,
                                       nil,
                                       Lookout::Mock::Method::Calls.new(0..0)).call
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls.new(0..1)).define.undefine
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls.new(0..1)).define.tap{ |m| m.call }.undefine
  end

  expect Lookout::Mock::Method::Calls::TooManyError do
    Lookout::Mock::Method::Defined.new(stub, :method, :public, nil, Lookout::Mock::Method::Calls.new(0..1)).tap{ |m| 2.times{ m.call } }
  end

  expect Lookout::Mock::Method::Calls::TooFewError.
    new('stub#method: unexpected number of invocations (0 for 1)', 0, 1..1) do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls.new(1..1)).define.undefine
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls.new(1..1)).define.tap{ |m| m.call }.undefine
  end

  expect Lookout::Mock::Method::Calls::TooManyError do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls.new(1..1)).define.tap{ |m| 2.times{ m.call } }.undefine
  end

  expect Lookout::Mock::Method::Calls::TooFewError do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls.new(1..1.0/0)).define.undefine
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls.new(1..1.0/0)).define.tap{ |m| m.call }.undefine
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls.new(1..1.0/0)).define.tap{ |m| 2.times{ m.call } }.undefine
  end

  expect Lookout::Mock::Method::Arguments::Error.new('stub#method: unexpected arguments ([]≠[1])') do
    Lookout::Mock::Method::Defined.new(stub, :method, :public, nil, Lookout::Mock::Method::Calls.new(1..1), 1).call
  end
end
