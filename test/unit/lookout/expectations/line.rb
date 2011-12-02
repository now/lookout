# -*- coding: utf-8 -*-

Expectations do
  expect [Lookout::Results::Failures::State] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations::Line.new(results, __FILE__, __LINE__ + 1).evaluate do
        expect(1){ 2 }
        expect(1){ 1 }
      end
    }.entries
  end

  expect [Lookout::Results::Failures::State] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations::Line.new(results, __FILE__, __LINE__ + 1).evaluate{
        expect(1){ 2 }
        expect(1){ 1 }
      }
    }.entries
  end

  expect [Lookout::Results::Failures::State] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations::Line.new(results, __FILE__, __LINE__ + 2).evaluate{
        expect(1){ 1 }
        expect(1){ 2 }
      }
    }.entries
  end

  expect [Lookout::Results::Error] do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations::Line.new(results, __FILE__, __LINE__ + 1).evaluate{
      }
    }.entries
  end
end
