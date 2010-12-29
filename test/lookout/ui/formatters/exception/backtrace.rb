# -*- coding: utf-8 -*-

Expectations do
  expect [%r{test.*backtrace\.rb}] do
    expectations = Lookout::Expectations.new
    expectations.expect(1){ raise }
    Lookout::Results::Error::Exception::Backtrace.
      new(expectations.evaluate(Lookout::UI::Silent.new).first.exception.exception.backtrace,
          true).backtrace
  end
end
