# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls::Exactly.new(0)).define.undefine
  end

  expect Lookout::Mock::Method::Calls::TooManyError.new('stub#method: unexpected number of invocations (1 for 0)') do
    Lookout::Mock::Method::Defined.new(stub, :method, Lookout::Mock::Method::Calls::Exactly.new(0)).call
  end

  expect Lookout::Mock::Method::Calls::TooManyError.new('Class.method: unexpected number of invocations (1 for 0)') do
    Lookout::Mock::Method::Defined.new(Class, :method, Lookout::Mock::Method::Calls::Exactly.new(0)).call
  end

  expect Lookout::Mock::Method::Calls::TooManyError.new('(cannot inspect object: error)#method: unexpected number of invocations (1 for 0)') do
    Lookout::Mock::Method::Defined.new(stub(:inspect => proc{ raise 'error' } ),
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(0)).call
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls::Upper.new(1)).define.undefine
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls::Upper.new(1)).define.tap{ |m| m.call }.undefine
  end

  expect Lookout::Mock::Method::Calls::TooManyError do
    Lookout::Mock::Method::Defined.new(stub, :method, Lookout::Mock::Method::Calls::Upper.new(1)).tap{ |m| 2.times{ m.call } }
  end

  expect Lookout::Mock::Method::Calls::TooFewError.new('stub#method: unexpected number of invocations (0 for 1)') do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls::Exactly.new(1)).define.undefine
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls::Exactly.new(1)).define.tap{ |m| m.call }.undefine
  end

  expect Lookout::Mock::Method::Calls::TooManyError do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls::Exactly.new(1)).define.tap{ |m| 2.times{ m.call } }.undefine
  end

  expect Lookout::Mock::Method::Calls::TooFewError do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls::Lower.new(1)).define.undefine
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls::Lower.new(1)).define.tap{ |m| m.call }.undefine
  end

  expect Lookout::Mock::Method::Undefined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Calls::Lower.new(1)).define.tap{ |m| 2.times{ m.call } }.undefine
  end

  expect Lookout::Mock::Method::Arguments::Error.new('stub#method: unexpected arguments ([]≠[1])') do
    Lookout::Mock::Method::Defined.new(stub, :method, Lookout::Mock::Method::Calls::Exactly.new(1), 1).call
  end
end
