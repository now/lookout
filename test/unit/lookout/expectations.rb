# -*- coding: utf-8 -*-

Expectations do
  expect true do
    expectations = Lookout::Expectations.new
    expectations.evaluate(Lookout::UI::Silent.new).succeeded?
  end

  expect false do
    expectations = Lookout::Expectations.new
    expectations.expect(1){ 2 }
    expectations.evaluate(Lookout::UI::Silent.new).succeeded?
  end

  expect 3 do
    expectations = Lookout::Expectations.new
    expectations.expect(1){ 2 }
    expectations.expect(1){ 2 }
    expectations.expect(1){ 2 }
    expectations.count
  end

  expect 1 do
    expectations = Lookout::Expectations.new
    expectations.expect(1){ 2 }
    expectations.expect(1){ 2 }
    expectations.each(__LINE__ - 1).count
  end

  expect __LINE__ + 2 do
    expectations = Lookout::Expectations.new
    expectations.expect(1){ 2 }
    expectations.first.line
  end

  expect __LINE__ + 2 do
    expectations = Lookout::Expectations.new
    expectations.expect(1){ raise }
    expectations.first.line
  end

  expect __FILE__ do
    expectations = Lookout::Expectations.new
    expectations.expect(1){ 2 }
    expectations.first.file
  end

  expect __FILE__ do
    expectations = Lookout::Expectations.new
    expectations.expect(1){ raise }
    expectations.first.file
  end

  expect Object.new do |o|
    expectations = Lookout::Expectations.new
    expectations.evaluate(Lookout::UI::Silent.new, o)
  end
end