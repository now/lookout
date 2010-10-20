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
    suite.count
  end

  expect 1 do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.expect(1){ 2 }
    suite.each(__LINE__ - 1).count
  end

  expect __LINE__ + 2 do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.first.line
  end

  expect __LINE__ + 2 do
    suite = Lookout::Suite.new
    suite.expect(1){ raise }
    suite.first.line
  end

  expect __FILE__ do
    suite = Lookout::Suite.new
    suite.expect(1){ 2 }
    suite.first.file
  end

  expect __FILE__ do
    suite = Lookout::Suite.new
    suite.expect(1){ raise }
    suite.first.file
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
