# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).never.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected stub.method(*args, &block) not to be called') do
    Lookout::Mock::Method.new(stub, :method).never.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error.
    new('expected (cannot inspect object: error).method(*args, &block) not to be called') do
    Lookout::Mock::Method.new(stub(:inspect => proc{ raise 'error' } ),
                              :method).never.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).never.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).never.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).at_most_once.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).at_most_once.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).at_most_once.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).once.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).once.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).once.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).once.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).at_least_once.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).at_least_once.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).at_least_once.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).twice.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).twice.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).twice.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).twice.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).at_least(2).verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).at_least(2).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).at_least(2).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).at_least(2).tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).exactly(2).verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).exactly(2).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).exactly(2).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).exactly(2).tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).at_most(2).verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).at_most(2).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :method).at_most(2).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :method).at_most(2).tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Arguments::Error.new('stub.method(1, 2, 3): unexpected arguments: (4, 5, 6)≠(1, 2, 3)') do
    Lookout::Mock::Method.new(stub, :method, 1, 2, 3).call(4, 5, 6)
  end
end
