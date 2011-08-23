# -*- coding: utf-8 -*-

Expectations do
  expect "\tfrom 1
\tfrom 2
\tfrom 3
\tfrom 4
\tfrom 5
\tfrom 6
\tfrom 7
\tfrom 8
\t ... 6 levels ...
\tfrom A
\tfrom B
\tfrom C
\tfrom D
\tfrom E" do
    Lookout::Results::Error::Exception::Backtrace.new(%w[1 2 3 4 5 6 7 8 a b c d e f A B C D E], true, false).to_s
  end
end
