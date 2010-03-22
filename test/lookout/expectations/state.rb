# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [Lookout::Results::Failures::State] do
    suite = Lookout::Suite.new
    suite.expect(2){ 3 }
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Error] do
    suite = Lookout::Suite.new
    suite.expect(2){ stub(:two => 2).twos }
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Error] do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect(2) do
      Object.expects(:bar).returns 2
      Object.barter
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Error] do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect(1) do
      Object.expects(:give_me_three).with(3).returns 1
      Object.give_me_three(stub(:three => 3).threes)
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Error] do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect(1) do
      Object.expects(:foo)
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Error] do
    $VERBOSE = nil
    suite = Lookout::Suite.new
    suite.expect(1) do
      mock(:foo => 1)
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Fulfilled] do
    suite = Lookout::Suite.new
    suite.expect(NoMethodError){ Object.no_method }
    suite.execute(Lookout::UI::Silent).entries
  end
end
