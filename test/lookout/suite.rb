# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect true do
    suite = Lookout::Suite.new
    suite.execute(Lookout::UI::Silent).succeeded?
  end

  expect true do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.do_not_run
    suite.execute(Lookout::UI::Silent).succeeded?
  end

  expect false do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.execute(Lookout::UI::Silent).succeeded?
  end

  expect 3 do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.expect(1){ 2 }
    suite.expect(1){ 2 }
    suite.expectations_for(nil).size
  end

  expect 1 do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.expect(1){ 2 }
    suite.expectations_for(__LINE__ - 1).size
  end

  expect :expected do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.expect(:expected) { 2 }
    suite.expectations_for(__LINE__ - 1).first.expected
  end

  expect __LINE__ + 2 do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.expectations.first.line
  end

  expect __LINE__ + 2 do
    suite = Lookout::Suite.new
    suite.expect(1){ raise }
    suite.expectations.first.line
  end

  expect __FILE__ do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.expectations.first.file
  end

  expect __FILE__ do
    suite = Lookout::Suite.new
    suite.expect(1){ raise }
    suite.expectations.first.file
  end

  expect Object.new do |o|
    suite = Lookout::Suite.new
    suite.do_not_run
    suite.execute(Lookout::UI::Silent, o)
  end

  expect Lookout::Suite::Results do
    suite = Lookout::Suite.new
    suite.do_not_run
    suite.execute(Lookout::UI::Silent)
  end
end
