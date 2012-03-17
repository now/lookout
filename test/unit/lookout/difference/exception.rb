# -*- coding: utf-8 -*-

Expectations do
  expect [] do
    RuntimeError.new.to_lookout_expected.difference(ArgumentError.new).diff
  end

  expect [] do
    RuntimeError.new(/a/).to_lookout_expected.difference(RuntimeError.new('b')).diff
  end

  expect [] do
    RuntimeError.new('a').to_lookout_expected.difference(RuntimeError.new('b').tap{ |o| stub(o).message{ raise } }).diff
  end

  expect [] do
    RuntimeError.new('a').to_lookout_expected.difference(RuntimeError.new('b').tap{ |o| stub(o).message{ nil } }).diff
  end

  expect '[-b-]{+a+}' do
    RuntimeError.new('a').to_lookout_expected.difference(RuntimeError.new('b')).diff.to_s
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: a>' do
    RuntimeError.new('a').to_lookout_expected.difference(RuntimeError.new('b')).message
  end

  expect '(cannot inspect actual result: error)≠#<RuntimeError: a>' do
    RuntimeError.new('a').to_lookout_expected.difference(RuntimeError.new('b').tap{ |o| stub(o).inspect{ raise 'error' } }).message
  end

  expect '#<RuntimeError: b>≉#<RuntimeError: /a/>' do
    RuntimeError.new(/a/).to_lookout_expected.difference(RuntimeError.new('b')).message
  end

  expect '#<RuntimeError: b>≉#<RuntimeError: /a/m>' do
    RuntimeError.new(/a/m).to_lookout_expected.difference(RuntimeError.new('b')).message
  end

  expect '#<RuntimeError: b>≉#<RuntimeError: /a/i>' do
    RuntimeError.new(/a/i).to_lookout_expected.difference(RuntimeError.new('b')).message
  end

  expect '#<RuntimeError: b>≉#<RuntimeError: /a/x>' do
    RuntimeError.new(/a/x).to_lookout_expected.difference(RuntimeError.new('b')).message
  end

  expect '#<RuntimeError: b>≉#<RuntimeError: /a/mix>' do
    RuntimeError.new(/a/mix).to_lookout_expected.difference(RuntimeError.new('b')).message
  end

  expect '(cannot inspect actual result: error)≠#<RuntimeError: a>' do
    RuntimeError.new('a').to_lookout_expected.difference(RuntimeError.new('b').tap{ |o| stub(o).inspect{ raise 'error' } }).message
  end

  expect '(cannot inspect actual result: error)≉#<RuntimeError: /a/>' do
    RuntimeError.new(/a/).to_lookout_expected.difference(RuntimeError.new('b').tap{ |o| stub(o).inspect{ raise 'error' } }).message
  end
end
