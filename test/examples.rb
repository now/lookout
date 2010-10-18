# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  # State-based Expectations

  # Determine if the result equals a value.
  expect 2 do
    1 + 1
  end

  # Determine if the result, retrieved through a stub, equals a value.
  expect 2 do
    Object.new.tap{ |o| stub(o).two{ 2 } }.two
  end

  # Match against a Regexp.  Please note the use of parentheses to silence
  # warnings.
  expect(/a string/) do
    'a string'
  end

  # Match inside a Range.
  expect 1..5 do
    3
  end

  # Verify that the result is an Enumerable.
  expect Enumerable do
    []
  end

  # Verify that the result is a String.
  expect String do
    'a string'
  end

  # Determine equality of modules.
  expect Enumerable do
    Enumerable
  end

  # Determine equality of classes.
  expect String do
    String
  end

  # Verify that the result is truthful.
  expect true do
    1
  end

  # Verify that the result is “falseful”.
  expect false do
    nil
  end

  # Verify that the result is actually true.
  expect TrueClass do
    true
  end

  # Verify that the result is actually false.
  expect FalseClass do
    false
  end

  # Match XML contents, ignoring whitespace between tags.
  expect xml('<a><foo>bar</foo></a>') do
    "<a>\n\t<foo>bar</foo>  \n</a>"
  end

  # Match XML contents, ignoring whitespace between tags.
  expect xml(<<-EOX) do
    <one>
      <two>
        <three>4</three>
        <five> 6 </five>
      </two>
    </one>
  EOX
    '<one><two><three>4</three>
     <five> 6 </five>
     </two></one>'
  end

  # Verify that an exception is raised.
  expect NoMethodError do
    Object.no_method
  end

  # State-based Fluent Boolean Expectations

  # Expect an object to “be” something.
  klass = Class.new{ attr_accessor :running }
  expect klass.new.to.be.running do |process|
    process.running = true
  end

  # Expect an object to “have” something.
  klass = Class.new{ attr_accessor :finished }
  expect klass.new.to.have.finished do |process|
    process.finished = true
  end

  # Expect nil to be nil.
  expect nil.to.be.nil?

  # Expect Object not to be nil.
  expect Object.not.to.be.nil?

  # State-based Delegation Expectations

  # Expect #save to delegate to #record.
  expect Class.new{ def save(arg) record.save(arg) end }.
           new.to.delegate(:save).to(:record) do |instance|
    instance.save(1)
  end

  # Behavior-based Expectations

  # Use a mock to verify that a method is called appropriately.
  expect mock.to.receive.dial('2125551212').twice do |phone|
    phone.dial('2125551212')
    phone.dial('2125551212')
  end

  # Use a stub that ignores all calls to verify that a method is called
  # appropriately.  Any other calls made are ignored.
  expect stub.to.receive.dial('2125551212').twice do |phone|
    phone.dial('2125551212')
    phone.hangup
    phone.dial('2125551212')
  end

  # Use a contrete mock to verify that a method is called.
  expect Object.to.receive.deal do
    Object.deal
  end
end
