# -*- coding: utf-8 -*-

Expectations do
  expect [Lookout::Results::Failures::Behavior] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect Object.new.to.receive.dial('2125551212').twice do |phone|
        phone.dial('2125551212')
      end
    }.entries
  end

  expect [Lookout::Results::Failures::Behavior] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect Object.new.to.receive.dial('2125551212').twice do |phone|
        phone.dial('2125551212')
        phone.dial('2125551212')
        phone.dial('2125551212')
      end
    }.entries
  end

  expect [Lookout::Results::Failures::Behavior] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(Object.new.to.receive.deal)
    }.entries
  end

  expect [Lookout::Results::Error] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(Object.new.to.receive.foo) do
        raise StandardError
      end
    }.entries
  end
end
