# -*- coding: utf-8 -*-

Expectations do
  expect [Lookout::Results::Failures::State] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(2){ 3 }
    }.entries
  end

  expect [Lookout::Results::Error] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(2){ stub(Object.new).two{ 2 }.twos }
    }.entries
  end

  expect [Lookout::Results::Error] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect 1 do
        Object.new.tap{ |o| o.expects.give_me_three(3){ 1 } }.give_me_three(stub).threes
      end
    }.entries
  end

  expect [] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(NoMethodError){ Object.no_method }
    }.entries
  end
end
