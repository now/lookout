# -*- coding: utf-8 -*-

Expectations do
  expect '' do
    Lookout::Results::Error::Exception::Backtrace.from(nil).to_s
  end

  expect '' do
    Lookout::Results::Error::Exception::Backtrace.from(stub(:backtrace => nil)).to_s
  end

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
    Lookout::Results::Error::Exception::Backtrace.
      from(SystemStackError.new('error').tap{ |e|
             e.set_backtrace %w[1 2 3 4 5 6 7 8 a b c d e f A B C D E]
           }).to_s
  end

  expect "\tfrom a:1" do
    Lookout::Results::Error::Exception::Backtrace.new('a:1', false).to_s
  end

  expect "\tfrom a:1\n\tfrom b:2" do
    Lookout::Results::Error::Exception::Backtrace.new(%w'a:1 b:2', false).to_s
  end

  expect "\tfrom (cannot retrieve backtrace entry: error)" do
    Lookout::Results::Error::Exception::Backtrace.new(stub('a:1').encode{ raise 'error' }, false).to_s
  end

  expect "\tfrom a:1\n\tfrom (cannot retrieve backtrace entry: error)\n\tfrom c:3" do
    Lookout::Results::Error::Exception::Backtrace.new(['a:1', stub('a:1').encode{ raise 'error' }, 'c:3'], false).to_s
  end

  expect "\tfrom (backtrace is not an Array of String: 1)" do
    Lookout::Results::Error::Exception::Backtrace.new(1, false).to_s
  end

  expect "\tfrom a:1\n\tfrom b:2" do
    Lookout::Results::Error::Exception::Backtrace.
      new(['a:1',
           'b:2',
           File.join(Lookout::Results::Error::Exception::Backtrace::Root, 'c:3'),
           'd:4'],
          false,
          true).to_s
  end

  expect "\tfrom b:2\n\tfrom c:3\n\tfrom d:4" do
    Lookout::Results::Error::Exception::Backtrace.
      new([File.join(Lookout::Results::Error::Exception::Backtrace::Root, 'a:1'),
           'b:2',
           'c:3',
           'd:4'],
          false,
          true).to_s
  end
end
