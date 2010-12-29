# -*- coding: utf-8 -*-

Expectations do
  expect [Lookout::Results::Failures::Behavior] do
    expectations = Lookout::Expectations.new
    expectations.expect Object.new.to.receive.dial('2125551212').twice do |phone|
      phone.dial('2125551212')
    end
    expectations.evaluate(Lookout::UI::Silent.new).entries
  end

  expect [Lookout::Results::Failures::Behavior] do
    expectations = Lookout::Expectations.new
    expectations.expect Object.new.to.receive.dial('2125551212').twice do |phone|
      phone.dial('2125551212')
      phone.dial('2125551212')
      phone.dial('2125551212')
    end
    expectations.evaluate(Lookout::UI::Silent.new).entries
  end

  expect [Lookout::Results::Failures::Behavior] do
    expectations = Lookout::Expectations.new
    expectations.expect(Object.new.to.receive.deal){ }
    expectations.evaluate(Lookout::UI::Silent.new).entries
  end

  expect [Lookout::Results::Error] do
    expectations = Lookout::Expectations.new
    expectations.expect(Object.new.to.receive.foo) do
      raise StandardError
    end
    expectations.evaluate(Lookout::UI::Silent.new).entries
  end
end
