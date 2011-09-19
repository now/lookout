# -*- coding: utf-8 -*-

Expectations do
  expect 1 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      expectations = Lookout::Expectations::Line.new(__LINE__ + 1, results)
      expectations.expect(1){ 2 }
      expectations.expect(1){ 2 }
    }.count
  end

  expect 1 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      expectations = Lookout::Expectations::Line.new(__LINE__ + 1, results)
      expectations.expect(1){ 2 }
      expectations.expect(1){ 2 }
      expectations.flush
    }.count
  end

  expect 1 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      expectations = Lookout::Expectations::Line.new(__LINE__ + 2, results)
      expectations.expect(1){ 2 }
      expectations.expect(1){ 2 }
      expectations.flush
    }.count
  end
end
