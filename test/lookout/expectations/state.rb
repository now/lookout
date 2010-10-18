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
    suite.expect(2){ stub(Object.new).two{ 2 }.twos }
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Error] do
    suite = Lookout::Suite.new
    suite.expect(1) do
      Object.new.tap{ |o| o.expects.give_me_three(3){ 1 } }.give_me_three(stub).threes
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Fulfilled] do
    suite = Lookout::Suite.new
    suite.expect(NoMethodError){ Object.no_method }
    suite.execute(Lookout::UI::Silent).entries
  end
end
