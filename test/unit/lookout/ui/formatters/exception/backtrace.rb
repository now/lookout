# -*- coding: utf-8 -*-

Expectations do
  expect [%r{test.*backtrace\.rb}] do
    results = Lookout::Results::Unsuccessful.new
    Lookout::Expectations.new(results).expect(1){ raise }
    Lookout::Results::Error::Exception::Backtrace.
      new(results.first.exception.exception.backtrace, true).backtrace
  end
end
