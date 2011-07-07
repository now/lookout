# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results)
    }.succeeded?
  end

  expect false do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).expect(1){ 2 }
    }.succeeded?
  end

  expect 3 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      Lookout::Expectations.new(results).
        expect(1){ 2 }.
        expect(1){ 2 }.
        expect(1){ 2 }
    }.count
  end

  expect 1 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      expectations = Lookout::Expectations.new(results, __LINE__ + 1)
      expectations.expect(1){ 2 }
      expectations.expect(1){ 2 }
    }.count
  end

  expect 1 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      expectations = Lookout::Expectations.new(results, __LINE__ + 1)
      expectations.expect(1){ 2 }
      expectations.expect(1){ 2 }
      expectations.flush
    }.count
  end

  expect 1 do
    Lookout::Results::Unsuccessful.new.tap{ |results|
      expectations = Lookout::Expectations.new(results, __LINE__ + 2)
      expectations.expect(1){ 2 }
      expectations.expect(1){ 2 }
      expectations.flush
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
