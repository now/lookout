# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Exception do
    RuntimeError.new('a').to_lookout_expected.actualize('test', 1)
  end

  expect true do
    a = RuntimeError.new('a')
    a.to_lookout_expected =~ a
  end

  expect true do
    RuntimeError.new('a').to_lookout_expected =~ (begin raise 'a'; rescue => e; e end)
  end

  expect false do
    RuntimeError.new('a').to_lookout_expected =~ RuntimeError.new('b')
  end

  expect false do
    RuntimeError.new('a').to_lookout_expected =~ StandardError.new('a')
  end

  expect nil do
    RuntimeError.new('a').to_lookout_expected.diff(RuntimeError.new('b').tap{ |o| stub(o).message{ nil } })
  end

  expect '[-b-]{+a+}' do
    RuntimeError.new('a').to_lookout_expected.diff(RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: a>: [-b-]{+a+}' do
    RuntimeError.new('a').to_lookout_expected.message(RuntimeError.new('b'))
  end

  expect '(cannot inspect actual result: error)≠#<RuntimeError: a>: [-b-]{+a+}' do
    RuntimeError.new('a').to_lookout_expected.message(RuntimeError.new('b').tap{ |o| stub(o).inspect{ raise 'error' } })
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/>' do
    RuntimeError.new(/a/).to_lookout_expected.message(RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/m>' do
    RuntimeError.new(/a/m).to_lookout_expected.message(RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/i>' do
    RuntimeError.new(/a/i).to_lookout_expected.message(RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/x>' do
    RuntimeError.new(/a/x).to_lookout_expected.message(RuntimeError.new('b'))
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: /a/mix>' do
    RuntimeError.new(/a/mix).to_lookout_expected.message(RuntimeError.new('b'))
  end

  expect '(cannot inspect actual result: error)≠#<RuntimeError: a>: [-b-]{+a+}' do
    RuntimeError.new('a').to_lookout_expected.message(RuntimeError.new('b').tap{ |o| stub(o).inspect{ raise 'error' } })
  end

  expect '(cannot inspect actual result: error)≠#<RuntimeError: /a/>' do
    RuntimeError.new(/a/).to_lookout_expected.message(RuntimeError.new('b').tap{ |o| stub(o).inspect{ raise 'error' } })
  end
end
