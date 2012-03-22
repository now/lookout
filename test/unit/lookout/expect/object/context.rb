# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Stub::Object do
    Lookout::Expect::Object::Context.new{ stub }.evaluate
  end

  expect Object.new do |o|
    Lookout::Expect::Object::Context.new{ stub(o).a }.evaluate
  end

  expect Lookout::Stub::Object do
    Lookout::Expect::Object::Context.new{ stub(:a => 1) }.evaluate
  end

  expect 1 do
    Lookout::Expect::Object::Context.new{ stub(:a => 1).a }.evaluate
  end

  expect 1 do
    Lookout::Expect::Object::Context.new{ stub(:a => proc{ 1 }).a }.evaluate
  end

  expect 1 do
    Lookout::Expect::Object::Context.new{ Object.new.tap{ |o| stub(o).a{ 1 } }.a }.evaluate
  end

  expect ArgumentError do
    Lookout::Expect::Object::Context.new{ Object.new.tap{ |o| stub(o).a(1){ 1 } }.a }.evaluate
  end

  expect true do
    Lookout::Expect::Object::Context.new{ with_verbose{ $VERBOSE }  }.evaluate
  end

  expect false do
    Lookout::Expect::Object::Context.new{ with_verbose(false){ $VERBOSE }  }.evaluate
  end

  expect true do
    Lookout::Expect::Object::Context.new{
      saved_verbose = $VERBOSE
      with_verbose{ $VERBOSE }
      $VERBOSE == saved_verbose
    }.evaluate
  end

  expect true do
    Lookout::Expect::Object::Context.new{
      saved_verbose = $VERBOSE
      with_verbose(false){ $VERBOSE }
      $VERBOSE == saved_verbose
    }.evaluate
  end

  expect 'hello' do
    with_constant 'Inventory::Rake::Tasks', 'hello' do
      ::Inventory::Rake::Tasks
    end
  end
end
