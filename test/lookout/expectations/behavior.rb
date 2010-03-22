# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect Lookout::Results::Failures::Behavior do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect mock.to.receive(:dial).with("2125551212").times(2) do |phone|
      phone.dial("2125551212")
      phone.dial("2125551212")
      phone.dial("2125551212")
    end
    suite.execute(Lookout::UI::Silent).entries.first
  end

  expect [Lookout::Results::Failures::Behavior] do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect mock.to.receive(:dial).with("2125551212").times(2) do |phone|
      phone.dial("2125551212")
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Failures::Behavior] do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect(Object.to.receive(:deal)) {  }
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Failures::Behavior] do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect(Object.to.receive(:foo)) do
      Object.foo
      mock(:foo => 1)
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Failures::Behavior] do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect(Object.to.receive(:foo)) do
      Object.foo
      Object.expects(:bar)
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Error] do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect(Object.to.receive(:foo)) do
      raise StandardError
    end
    suite.execute(Lookout::UI::Silent).entries
  end
end
