# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect [%r{test.*backtrace\.rb}] do
    suite = Lookout::Suite.new
    suite.expect(1){ raise }
    Lookout::UI::Formatters::Backtrace.
      new(suite.execute(Lookout::UI::Silent).first.exception.backtrace,
          true).backtrace
  end
end
