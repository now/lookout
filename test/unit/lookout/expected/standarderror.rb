# -*- coding: utf-8 -*-

Expectations do
  expect true do
    a = RuntimeError.new('a')
    a.to_lookout_expected =~ a
  end

  expect true do
    RuntimeError.new('a').to_lookout_expected =~ (begin raise 'a'; rescue => e; e end)
  end

  expect false do
    RuntimeError.new('a') =~ RuntimeError.new('b')
  end

  expect false do
    RuntimeError.new('a') =~ StandardError.new('a')
  end

  expect nil do
    Lookout::Equality.diff(stub(:message => nil), RuntimeError.new('b'))
  end

  expect nil do
    Lookout::Equality.diff(RuntimeError.new('a'), RuntimeError.new('b').tap{ |o| stub(o).message{ nil } })
  end

  expect '[-b-]{+a+}' do
    Lookout::Equality.diff(RuntimeError.new('a'), RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: a>: [-b-]{+a+}' do
    Lookout::Equality.message(RuntimeError.new('a'), RuntimeError.new('b'))
  end

  expect '(cannot inspect actual result: error)≠#<RuntimeError: a>: [-b-]{+a+}' do
    Lookout::Equality.message(RuntimeError.new('a'), RuntimeError.new('b').tap{ |o| stub(o).inspect{ raise 'error' } })
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/>' do
    Lookout::Equality.message(RuntimeError.new(/a/), RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/m>' do
    Lookout::Equality.message(RuntimeError.new(/a/m), RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/i>' do
    Lookout::Equality.message(RuntimeError.new(/a/i), RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/x>' do
    Lookout::Equality.message(RuntimeError.new(/a/x), RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/mix>' do
    Lookout::Equality.message(RuntimeError.new(/a/mix), RuntimeError.new('b'))
  end

  expect '(cannot inspect actual result: error)≠#<RuntimeError: a>: [-b-]{+a+}' do
    Lookout::Equality.message(RuntimeError.new('a'), RuntimeError.new('b').tap{ |o| stub(o).inspect{ raise 'error' } })
  end

  expect '(cannot inspect actual result: error)≠#<RuntimeError: /a/>' do
    Lookout::Equality.message(RuntimeError.new(/a/), RuntimeError.new('b').tap{ |o| stub(o).inspect{ raise 'error' } })
  end
end
