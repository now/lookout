# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).never.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).never.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).never.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).never.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).at_most_once.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).at_most_once.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).at_most_once.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).once.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).once.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).once.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).once.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).at_least_once.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).at_least_once.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).at_least_once.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).twice.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).twice.tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).twice.tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).twice.tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).at_least(2).verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).at_least(2).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).at_least(2).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).at_least(2).tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).exactly(2).verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).exactly(2).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).exactly(2).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).exactly(2).tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).at_most(2).verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).at_most(2).tap{ |m| m.call }.verify
  end

  expect Lookout::Mock::Method do
    Lookout::Mock::Method.new(ignore, :a).at_most(2).tap{ |m| 2.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock::Method.new(ignore, :a).at_most(2).tap{ |m| 3.times{ m.call } }.verify
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method.new(ignore, :a, 1, 2, 3).call(4, 5, 6)
  end

  expect Lookout::Mock::Method::Arguments::Error do
    Lookout::Mock::Method.new(ignore, :a, 1, 2, 3).call(4, 5, 6)
  end
end
