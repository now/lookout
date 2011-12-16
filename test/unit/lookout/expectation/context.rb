# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Stub::Object do
    Lookout::Expectation::Context.new{ stub }.evaluate
  end

  expect Lookout::Stub::Method do
    Lookout::Expectation::Context.new{ stub(Object.new).a }.evaluate
  end

  expect Lookout::Stub::Object do
    Lookout::Expectation::Context.new{ stub(:a => 1) }.evaluate
  end

  expect 1 do
    Lookout::Expectation::Context.new{ stub(:a => 1).a }.evaluate
  end

  expect 1 do
    Lookout::Expectation::Context.new{ stub(:a => proc{ 1 }).a }.evaluate
  end

  expect 1 do
    Lookout::Expectation::Context.new{ Object.new.tap{ |o| stub(o).a{ 1 } }.a }.evaluate
  end

  expect ArgumentError.new('wrong number of arguments (1 for 0): stub(…).a(1){ … } should be stub(…).a{ … }') do
    Lookout::Expectation::Context.new{ Object.new.tap{ |o| stub(o).a(1){ 1 } }.a }.evaluate
  end

  expect true do
    Lookout::Expectation::Context.new{ with_verbose{ $VERBOSE }  }.evaluate
  end

  expect false do
    Lookout::Expectation::Context.new{ with_verbose(false){ $VERBOSE }  }.evaluate
  end

  expect true do
    Lookout::Expectation::Context.new{
      saved_verbose = $VERBOSE
      with_verbose{ $VERBOSE }
      $VERBOSE == saved_verbose
    }.evaluate
  end

  expect true do
    Lookout::Expectation::Context.new{
      saved_verbose = $VERBOSE
      with_verbose(false){ $VERBOSE }
      $VERBOSE == saved_verbose
    }.evaluate
  end
end
