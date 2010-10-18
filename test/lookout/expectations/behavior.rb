# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [Lookout::Results::Failures::Behavior] do
    suite = Lookout::Suite.new
    suite.expect Object.new.to.receive.dial('2125551212').twice do |phone|
      phone.dial('2125551212')
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Failures::Behavior] do
    suite = Lookout::Suite.new
    suite.expect Object.new.to.receive.dial('2125551212').twice do |phone|
      phone.dial('2125551212')
      phone.dial('2125551212')
      phone.dial('2125551212')
    end
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Failures::Behavior] do
    suite = Lookout::Suite.new
    suite.expect(Object.new.to.receive.deal){ }
    suite.execute(Lookout::UI::Silent).entries
  end

  expect [Lookout::Results::Error] do
    suite = Lookout::Suite.new
    suite.expect(Object.new.to.receive.foo) do
      raise StandardError
    end
    suite.execute(Lookout::UI::Silent).entries
  end
end
