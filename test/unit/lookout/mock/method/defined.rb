# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Defined do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(0)).
      verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected stub.method(*args, &block) not to be called') do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(0)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error.
    new('expected (cannot inspect object: error).method(*args, &block) not to be called') do
    Lookout::Mock::Method::Defined.new(stub(:inspect => proc{ raise 'error' } ),
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(0)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(0)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(0)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Upper.new(1)).
      verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Upper.new(1)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Upper.new(1)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(1)).
      verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(1)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(1)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(1)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Lower.new(1)).
      verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Lower.new(1)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Lower.new(1)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(2)).
      verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(2)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(2)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(2)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Lower.new(2)).
      verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Lower.new(2)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Lower.new(2)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Lower.new(2)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(2)).
      verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(2)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(2)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Exactly.new(2)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Upper.new(2)).
      verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Upper.new(2)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Upper.new(2)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Upper.new(2)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Arguments::Error.new('stub.method(1, 2, 3): unexpected arguments: (4, 5, 6)≠(1, 2, 3)') do
    Lookout::Mock::Method::Defined.new(stub,
                                       :method,
                                       Lookout::Mock::Method::Calls::Lower.new(1),
                                       1, 2, 3).call(4, 5, 6)
  end
end
