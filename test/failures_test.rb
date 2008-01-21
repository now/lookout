require File.dirname(__FILE__) + "/test_helper"

Expectations do
  expect Expectations::Results::StateBasedFailure do
    suite = Expectations::Suite.new
    suite.expect(2) { 3 }
    suite.execute(Silent)
    suite.expectations.first
  end
  
  expect Expectations::Results::Error do
    suite = Expectations::Suite.new
    suite.expect(ArgumentError) { Object.no_method }
    suite.execute(Silent)
    suite.expectations.first
  end

  expect Expectations::Results::BehaviorBasedFailure do
    suite = Expectations::Suite.new
    suite.expect(mock.to_receive(:dial).with("2125551212").times(2)) do |phone|
      phone.dial("2125551212")
      phone.dial("2125551212")
      phone.dial("2125551212")
    end
    suite.execute(Silent)
    suite.expectations.first
  end

  expect Expectations::Results::BehaviorBasedFailure do
    suite = Expectations::Suite.new
    suite.expect(mock.to_receive(:dial).with("2125551212").times(2)) { |phone| phone.dial("2125551212") }
    suite.execute(Silent)
    suite.expectations.first
  end

  expect Expectations::Results::BehaviorBasedFailure do
    suite = Expectations::Suite.new
    suite.expect(Object.to_receive(:deal)) {  }
    suite.execute(Silent)
    suite.expectations.first
  end

  expect Expectations::Results::Error do
    suite = Expectations::Suite.new
    suite.expect(2) { stub(:two => 2).twos }
    suite.execute(Silent)
    suite.expectations.first
  end

  expect Expectations::Results::Error do
    suite = Expectations::Suite.new
    suite.expect(2) do
      Object.expects(:bar).returns 2
      Object.barter
    end
    suite.execute(Silent)
    suite.expectations.first
  end

  expect Expectations::Results::Error do
    suite = Expectations::Suite.new
    suite.expect(1) do
      Object.expects(:give_me_three).with(3).returns 1
      Object.give_me_three(stub(:three=>3).threes)
    end
    suite.execute(Silent)
    suite.expectations.first
  end

end