# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Stub do
    Lookout::Expect::Object::Context.new{ stub }.evaluate
  end

  expect Object.new do |o|
    Lookout::Expect::Object::Context.new{ stub(o, :a => 1){ |e| e } }.evaluate
  end

  expect Object.new do |o|
    Lookout::Expect::Object::Context.new{ stub(o, :a => 1){ |e| stub(e, :b => 2){ |f| f } } }.evaluate
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

  expect 'hello' do
    with_global :$stdout, StringIO.new do
      print 'hello'
      $stdout.string
    end
  end

  expect ArgumentError.new('no such global variable: $THIS_IS_NOT_THE_NAME_OF_A_GLOBAL') do
    with_global :$THIS_IS_NOT_THE_NAME_OF_A_GLOBAL, StringIO.new do
      print 'hello'
      $stdout.string
    end
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
    with_const 'Inventory::Rake::Tasks', 'hello' do
      ::Inventory::Rake::Tasks
    end
  end

  expect 'hello' do
    with_const '::Inventory::Rake::Tasks', 'hello' do
      ::Inventory::Rake::Tasks
    end
  end

  expect NameError do
    with_const '::', 'hello' do
    end
  end

  expect NameError do
    with_const '::::', 'hello' do
    end
  end

  expect NameError do
    with_const '::::::', 'hello' do
    end
  end

  expect NameError do
    with_const '::Inventory::Rake::Tasks::', 'hello' do
    end
  end

  expect NameError do
    with_const '::::Inventory::Rake::Tasks', 'hello' do
    end
  end

  expect '123' do
    with_env 'LINE' => '123' do
      ENV['LINE']
    end
  end
end
