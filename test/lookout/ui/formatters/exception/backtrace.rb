# -*- coding: utf-8 -*-

Expectations do
  expect [%r{test.*backtrace\.rb}] do
    expectations = Lookout::Expectations.new
    expectations.expect(1){ raise }
    Lookout::UI::Formatters::Exception::Backtrace.
      new(expectations.execute(Lookout::UI::Silent.new).first.exception.backtrace,
          true).backtrace
  end
end
