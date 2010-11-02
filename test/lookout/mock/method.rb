# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).never.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).never.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).never.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).never.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).at_most_once.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).at_most_once.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).at_most_once.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).once.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).once.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).once.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).once.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).at_least_once.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).at_least_once.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).at_least_once.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).twice.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).twice.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).twice.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).twice.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).at_least(2).verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).at_least(2).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).at_least(2).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).at_least(2).tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).exactly(2).verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).exactly(2).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).exactly(2).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).exactly(2).tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).at_most(2).verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).at_most(2).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(stub, :a).at_most(2).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(stub, :a).at_most(2).tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method.new(stub, :a, 1, 2, 3).call(4, 5, 6)
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method.new(stub, :a, 1, 2, 3).call(4, 5, 6)
  end
end
