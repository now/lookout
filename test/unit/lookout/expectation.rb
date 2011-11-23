# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Failures::State do
    Lookout::Expectation.on(1, nil, nil){ 2 }.evaluate
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.on(1, nil, nil){ 1 }.evaluate
  end

  expect Lookout::Results::Error do
    Lookout::Expectation.on(1, nil, nil){ raise }.evaluate
  end

  expect "undefined method `no_method' for Object:Class (NoMethodError)" do
    Lookout::Expectation.on(ArgumentError, nil, nil){ Object.no_method }.evaluate.exception.message
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.on(NoMethodError, nil, nil){ Object.no_method }.evaluate
  end

  expect Lookout::Recorders::State do
    ''.to.have.to_s == ''
  end

  expect Lookout::Results::Failures::State do
    Lookout::Expectation.on('foo'.to.have.to_s == 'bar', '', 0).evaluate
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.on('foo'.to.have.to_s == 'foo', nil, nil).evaluate
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.on([1, 2, 3].to.include?(1), nil, nil).evaluate
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.on(1, nil, nil){ stub(:a => 1).a }.evaluate
  end

  expect Lookout::Results::Fulfilled do
    Lookout::Expectation.on(1, nil, nil){ stub(:a => proc{ 1 }).a }.evaluate
  end
end
