# -*- coding: utf-8 -*-

Expectations do
  expect [Lookout::Results::Failure, Lookout::Results::Failure] do
    [].tap{ |results|
      Lookout::Expectations::Context.new{ |expect| results << expect.call }.instance_eval do
        expect(1){ 2 }
        expect(1){ 2 }
      end
    }
  end

  expect [Lookout::Results::Failure.new(__FILE__, __LINE__ + 3, '2≠1')] do
    [].tap{ |results|
      Lookout::Expectations::Context.new{ |expect| results << expect.call }.instance_eval do
        expect(1){ 2 }
      end
    }
  end
end
