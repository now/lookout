# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Defined do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).never.define.verify
  end

  expect Lookout::Mock::Method::Calls::Error.new('expected stub.method(*args, &block) not to be called') do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).never.define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error.
    new('expected (cannot inspect object: error).method(*args, &block) not to be called') do
    Lookout::Mock::Method::Undefined.new(stub(:inspect => proc{ raise 'error' } ),
                              :method, Lookout::Mock::Method::Arguments.new).never.define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).never.define.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).never.define.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_most_once.define.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_most_once.define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_most_once.define.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).once.define.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).once.define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).once.define.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).once.define.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).define.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).define.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_least_once.define.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_least_once.define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_least_once.define.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).twice.define.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).twice.define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).twice.define.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).twice.define.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_least(2).define.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_least(2).define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_least(2).define.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_least(2).define.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).exactly(2).define.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).exactly(2).define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).exactly(2).define.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).exactly(2).define.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_most(2).define.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_most(2).define.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_most(2).define.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new).at_most(2).define.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Arguments::Error.new('stub.method(1, 2, 3): unexpected arguments: (4, 5, 6)≠(1, 2, 3)') do
    Lookout::Mock::Method::Undefined.new(stub, :method, Lookout::Mock::Method::Arguments.new(1, 2, 3)).define.call(4, 5, 6)
  end
end
