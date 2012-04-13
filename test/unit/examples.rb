# -*- coding: utf-8 -*-

Expectations do
  # State-based Expectations

  # Determine if the result equals a value.
  expect 2 do
    1 + 1
  end

  # Verify that an exception is raised.
  expect ArgumentError do
    Integer('1 + 1')
  end

  # Verify that the result is an Array.
  expect Array do
    [1, 2, 3].select{ |i| i % 2 == 0 }
  end

  # Verify that the result is what we expect it to be.
  expect [2, 4, 6] do
    [1, 2, 3].map{ |i| i * 2 }
  end

  # Check that the result is within a given range.
  expect 0.099..0.101 do
    0.4 - 0.3
  end

  # Check an explicit result.
  expect 'ab' do
    'abc'[0..1]
  end

  # Match against a regexp (using %r{…} syntax to avoid a warning).
  expect %r{a substring} do
    'a string with a substring'
  end


  # Modules and Classes

  # Check that the result includes a given module.
  expect Enumerable do
    []
  end

  # Check that the result is of a given class.
  expect String do
    'a string'
  end

  # Verify the equality of modules.
  expect Enumerable do
    Enumerable
  end

  # Verify the equality of classes.
  expect String do
    String
  end


  # Booleans

  # Verify that the result is truthful.
  expect true do
    1
  end

  # Verify that the result is “falseful”.
  expect false do
    nil
  end

  # Verify that the result is literally true.
  expect TrueClass do
    true
  end

  # Verify that the result is literally false.
  expect FalseClass do
    false
  end


  # Output

  # Verify that the given text is output.
  expect output("abc\ndef\n") do |io|
    io.puts 'abc', 'def'
  end


  # Warnings

  # Expect a warning to be output.
  expect warning('this is your final one!') do
    warn 'this is your final one!'
  end

  # Expect a warning to be output; the “header” is automatically ignored.
  expect warning('this is your final one!') do
    warn '%s:%d: warning: this is your final one!' % [__FILE__, __LINE__]
  end


  # Verbosity

  # Use #with_verbose to set $VERBOSE during the execution of a block.
  expect nil do
    with_verbose(nil) do
      $VERBOSE
    end
  end


  # Exceptions

  # Verify that an exception is raised.
  expect ArgumentError do
    Integer('1 + 1')
  end

  # Verify that an exception with a specific message is raised.
  expect StandardError.new('message') do
    raise StandardError.new('message')
  end

  # Verify that an exception with a message matching a given Regexp is raised.
  expect StandardError.new(/mess/) do
    raise StandardError.new('message')
  end


  # Query Expectations

  # Expect #empty? on the result to be true.
  expect :empty? do
    []
  end

  # Equivalently, but less explicitly, expect #empty? on the result to be true.
  expect true do
    []
  end

  # Expect #empty? on the result to be false.
  expect :not_empty? do
    [1, 2, 3]
  end

  # Equivalently, but less explicitly, expect #empty? on the result to be false.
  expect false do
    [1, 2, 3].empty?
  end


  # Explicit Query Expectations

  # Expect [1, 2, 3] with all even integers removed to include 1.
  expect result.to.include? 1 do
    [1, 2, 3].reject{ |e| e.even? }
  end

  # Expect [1, 2, 3] with all even integers removed not to include 2.
  expect result.not.to.include? 2 do
    [1, 2, 3].reject{ |e| e.even? }
  end

  # Equivalently, but less explicitly, though marginally faster, expect [1, 2,
  # 3] with all even integers not to include 2.
  expect false do
    [1, 2, 3].reject{ |e| e.even? }.include? 2
  end


  # Literal Expectations

  # Expect the symbol :empty?, not #empty? on the result to be true.
  expect literal(:empty?) do
    :empty?
  end



  # Behavior-based Expectations

  # Use a mock to verify that a method is called appropriately.
  expect mock.to.receive.to_str(without_arguments){ '123' } do |o|
    o.to_str
  end

  # Use a stub that returns stub objects for unknown methods to only verify
  # that a method of interest is called appropriately.
  expect stub.to.receive.to_str(without_arguments){ '123' } do |o|
    o.to_str if o.convertable?
  end

  # Use a stub that’s set up with a set of methods.
  expect 3 do
    s = stub(:a => 1, :b => 2)
    s.a + s.b
  end

  # Use a stub that’s set up with a set of procs as methods.
  expect 3 do
    s = stub(:a => proc{ |a, b| a + b })
    s.a(1, 2)
  end

  # Stub out a specific method on an object.
  expect 'def' do
    a = 'abc'
    stub(a).to_str{ 'def' }
    a.to_str
  end

  # Stub out a specific method on an object without an intermediate.
  expect 'def' do
    stub('abc').to_str{ 'def' }.to_str
  end

  # Use a contrete mock to verify that a method is called.
  expect Object.to.receive.name do
    Object.name
  end

  # Expect the reception of #a with any number of arguments.
  expect mock.to.receive.a do |m|
    m.a
  end

  # Expect the reception of #a with one argument.
  expect mock.to.receive.a(Object) do |m|
    m.a 0
  end

  # Expect the reception of #a with either 1 or 2.
  expect mock.to.receive.a(1..2) do |m|
    m.a 1
  end

  # Expect the reception of #a without any arguments.
  expect mock.to.receive.a(without_arguments) do |m|
    m.a
  end

  # Expect the reception of #a with three arguments, the second being 1.
  expect mock.to.receive.a(Object, 2, Object) do |m|
    m.a nil, 2, '3'
  end

  # Expect the reception of #a and return 1 so that other code works.
  expect mock.to.receive.a{ 1 } do |m|
    raise 'not 1' unless m.a == 1
  end

  # Expect the reception of #a and call the block with 1.
  expect mock.to.receive.a{ |&b| b.call(1) } do |m|
    j = 0
    m.a{ |i| j = i }
    raise 'not 1' unless j == 1
  end

  # Stub out a specific method on an object.
  expect 6 do |m|
    account = Class.new{
      def slips
        raise 'database not available'
      end

      def total
        slips.reduce(0){ |m, n| m.to_i + n.to_i }
      end
    }.new
    stub(account).slips{ [1, 2, 3] }
    account.total
  end

  # Create a stub object that responds to specific methods.
  expect 3 do
    s = stub(:a => 1, :b => 2)
    s.a + s.b
  end

  # Expect the reception of #a on a stub object that responds to specific methods.
  expect stub(:a => 1, :b => 2).to.receive.a do |o|
    o.a + o.b
  end

  # Expect the reception of #a on a mock object that responds to specific methods.
  expect mock(:a => 2, :b => 2).to.receive.a do |o|
    o.a + o.b
  end



  # Utilities

  # Override the value of a constant during the execution of a block.
  expect 'hello' do
    with_constant 'A::B::C', 'hello' do
      A::B::C
    end
  end

  # Override/add environment keys/values during the execution of a block.
  expect 'hello' do
    with_environment 'INTRO' => 'hello' do
      ENV['INTRO']
    end
  end
end
