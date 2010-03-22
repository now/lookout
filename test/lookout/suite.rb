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

  expect false do
    suite = Lookout::Suite.new
    suite.expect(true){ true }
    suite.expect suite.mock.to.receive(:some_method) do |some_mock|
      # some_method is not called
    end
    suite.execute(Lookout::UI::Silent).succeeded?
  end

  expect Mocha::Mock do
    Lookout::Suite.new.mock
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

  expect o = Object.new do
    suite = Lookout::Suite.new
    suite.do_not_run
    suite.execute(Lookout::UI::Silent, o)
  end

  expect Lookout::Suite::Results do
    suite = Lookout::Suite.new
    suite.do_not_run
    suite.execute(Lookout::UI::Silent)
  end

  # Tests for #expect without block

  expect Lookout::Results::Failures::State do
    suite = Lookout::Suite.new
    suite.expect(3) == 4
    suite.execute(Lookout::UI::Silent)
    suite.expectations.first
  end

  expect Lookout::Results::Fulfilled do
    suite = Lookout::Suite.new
    suite.expect(3) == 3
    suite.execute(Lookout::UI::Silent)
    suite.expectations.first
  end

  expect Lookout::Results::Fulfilled do
    suite = Lookout::Suite.new
    suite.expect('foo bar') =~ /foo/
    suite.execute(Lookout::UI::Silent)
    suite.expectations.first
  end

  expect Lookout::Results::Failures::State do
    suite = Lookout::Suite.new
    suite.expect('bar') =~ /foo/
    suite.execute(Lookout::UI::Silent)
    suite.expectations.first
  end
end
