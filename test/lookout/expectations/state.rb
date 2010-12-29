# -*- coding: utf-8 -*-

Expectations do
  expect [Lookout::Results::Failures::State] do
    expectations = Lookout::Expectations.new
    expectations.expect(2){ 3 }
    expectations.execute(Lookout::UI::Silent.new).entries
  end

  expect [Lookout::Results::Error] do
    expectations = Lookout::Expectations.new
    expectations.expect(2){ stub(Object.new).two{ 2 }.twos }
    expectations.execute(Lookout::UI::Silent.new).entries
  end

  expect [Lookout::Results::Error] do
    expectations = Lookout::Expectations.new
    expectations.expect(1) do
      Object.new.tap{ |o| o.expects.give_me_three(3){ 1 } }.give_me_three(stub).threes
    end
    expectations.execute(Lookout::UI::Silent.new).entries
  end

  expect [Lookout::Results::Fulfilled] do
    expectations = Lookout::Expectations.new
    expectations.expect(NoMethodError){ Object.no_method }
    expectations.execute(Lookout::UI::Silent.new).entries
  end
end
