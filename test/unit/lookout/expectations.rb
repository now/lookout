# -*- coding: utf-8 -*-

Expectations do
  expect 3 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).
        expect(1){ 2 }.
        expect(1){ 2 }.
        expect(1){ 2 }
    }.count
  end

  expect __LINE__ + 2 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(1){ 2 }
    }.first.line
  end

  expect __LINE__ + 2 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(1){ raise }
    }.first.line
  end

  expect __FILE__ do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(1){ 2 }
    }.first.file
  end

  expect __FILE__ do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(1){ raise }
    }.first.file
  end
end
