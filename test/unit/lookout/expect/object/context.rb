# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Stub do
    Lookout::Expect::Object::Context.new{ stub }.evaluate
  end

  expect Object.new do |o|
    Lookout::Expect::Object::Context.new{ stub(o, :a => 1){ |e| e } }.evaluate
  end

  expect 1 do
    Lookout::Expect::Object::Context.new{ stub(Object.new, :a => 1){ |o| o.a } }.evaluate
  end

  expect false do
    Lookout::Expect::Object::Context.new{ stub(o = Object.new, :nil? => true){ }; o.nil? }.evaluate
  end

  expect Lookout::Stub do
    Lookout::Expect::Object::Context.new{ stub(:a => 1) }.evaluate
  end

  expect 1 do
    Lookout::Expect::Object::Context.new{ stub(:a => 1).a }.evaluate
  end

  expect 1 do
    Lookout::Expect::Object::Context.new{ stub(:a => proc{ 1 }).a }.evaluate
  end

  expect 1 do
    Lookout::Expect::Object::Context.new{ stub(Object.new, :a => 1){ |o| o.a } }.evaluate
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

  expect 'hello' do
    with_constant '::Inventory::Rake::Tasks', 'hello' do
      ::Inventory::Rake::Tasks
    end
  end

  expect NameError do
    with_constant '::Inventory::Rake::Tasks::', 'hello' do
      ::Inventory::Rake::Tasks
    end
  end

  expect '123' do
    with_environment 'LINE' => '123' do
      ENV['LINE']
    end
  end
end
