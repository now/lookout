# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Results::StateBasedFailure do
    suite = Lookout::Suite.new
    suite.expect(2) { 3 }
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::BehaviorBasedFailure do
    Lookout::StandardError.silence
    suite = Lookout::Suite.new
    suite.expect mock.to.receive(:dial).with("2125551212").times(2) do |phone|
      phone.dial("2125551212")
      phone.dial("2125551212")
      phone.dial("2125551212")
    end
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::BehaviorBasedFailure do
    Lookout::StandardError.stubs(:print)
    suite = Lookout::Suite.new
    suite.expect mock.to.receive(:dial).with("2125551212").times(2) do |phone|
      phone.dial("2125551212")
    end
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::BehaviorBasedFailure do
    Lookout::StandardError.stubs(:print)
    suite = Lookout::Suite.new
    suite.expect(Object.to.receive(:deal)) {  }
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::Error do
    suite = Lookout::Suite.new
    suite.expect(2) { stub(:two => 2).twos }
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::Error do
    Lookout::StandardError.stubs(:print)
    suite = Lookout::Suite.new
    suite.expect(2) do
      Object.expects(:bar).returns 2
      Object.barter
    end
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::Error do
    Lookout::StandardError.stubs(:print)
    suite = Lookout::Suite.new
    suite.expect(1) do
      Object.expects(:give_me_three).with(3).returns 1
      Object.give_me_three(stub(:three=>3).threes)
    end
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::Error do
    Lookout::StandardError.stubs(:print)
    suite = Lookout::Suite.new
    suite.expect(1) do
      Object.expects(:foo)
    end
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::Error do
    Lookout::StandardError.stubs(:print)
    suite = Lookout::Suite.new
    suite.expect(1) do
      mock(:foo => 1)
    end
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::BehaviorBasedFailure do
    Lookout::StandardError.stubs(:print)
    suite = Lookout::Suite.new
    suite.expect(Object.to.receive(:foo)) do
      Object.foo
      mock(:foo => 1)
    end
    suite.execute(Lookout::UI::Silent).expectations.first
  end

  expect Lookout::Results::BehaviorBasedFailure do
    Lookout::StandardError.stubs(:print)
    suite = Lookout::Suite.new
    suite.expect(Object.to.receive(:foo)) do
      Object.foo
      Object.expects(:bar)
    end
    suite.execute(Lookout::UI::Silent).expectations.first
  end

end
