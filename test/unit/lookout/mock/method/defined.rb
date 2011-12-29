# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Defined do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 0)).
      verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 0)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub(:inspect => proc{ raise 'error' } ),
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 0)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 0)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 0)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Upper.new(stub, :method, 1)).
      verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Upper.new(stub, :method, 1)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Upper.new(stub, :method, 1)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 1)).
      verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 1)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 1)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 1)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Lower.new(stub, :method, 1)).
      verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Lower.new(stub, :method, 1)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Lower.new(stub, :method, 1)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 2)).
      verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 2)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 2)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 2)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Lower.new(stub, :method, 2)).
      verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Lower.new(stub, :method, 2)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Lower.new(stub, :method, 2)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Lower.new(stub, :method, 2)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 2)).
      verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 2)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 2)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Exactly.new(stub, :method, 2)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Upper.new(stub, :method, 2)).
      verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Upper.new(stub, :method, 2)).
      tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Upper.new(stub, :method, 2)).
      tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Upper.new(stub, :method, 2)).
      tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method::Defined.
      new(stub,
          :method,
          Lookout::Mock::Method::Calls::Lower.new(stub, :method, 1),
          1, 2, 3).call(4, 5, 6)
  end
end
