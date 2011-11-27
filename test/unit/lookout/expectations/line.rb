# -*- coding: utf-8 -*-

Expectations do
  expect [Lookout::Results::Failures::State] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations::Line.new(__LINE__ + 1, results).evaluate do
        expect(1){ 2 }
        expect(1){ 1 }
      end
    }.entries
  end

  expect [Lookout::Results::Failures::State] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations::Line.new(__LINE__ + 1, results).evaluate{
        expect(1){ 2 }
        expect(1){ 1 }
      }
    }.entries
  end

  expect [Lookout::Results::Failures::State] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations::Line.new(__LINE__ + 2, results).evaluate{
        expect(1){ 1 }
        expect(1){ 2 }
      }
    }.entries
  end
end
