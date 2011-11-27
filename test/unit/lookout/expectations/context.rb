# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Unsuccessful.new.to.have.count.==(3) do |results|
    Lookout::Expectations.new(results).evaluate do
      expect(1){ 2 }
      expect(1){ 2 }
      expect(1){ 2 }
    end
  end

  expect [Lookout::Results::Failures::State.new(__FILE__, __LINE__ + 3, '2≠1')] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).evaluate do
        expect(1){ 2 }
      end
    }.entries
  end
end
