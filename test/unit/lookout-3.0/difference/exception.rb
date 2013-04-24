# -*- coding: utf-8 -*-

Expectations do
  expect [] do
    RuntimeError.new.to_lookout_expected.difference(ArgumentError.new).diff
  end

  expect [] do
    RuntimeError.new(/a/).to_lookout_expected.difference(RuntimeError.new('b')).diff
  end

  expect [] do
    stub(RuntimeError.new('b'), :message => proc{ raise }){ |b|
      RuntimeError.new('a').to_lookout_expected.difference(b).diff
    }
  end

  expect [] do
    stub(RuntimeError.new('b'), :message => nil){ |b|
      RuntimeError.new('a').to_lookout_expected.difference(b).diff
    }
  end

  expect '[-b-]{+a+}' do
    RuntimeError.new('a').to_lookout_expected.difference(RuntimeError.new('b')).diff.to_s
  end

  expect '#<RuntimeError: b>≠#<RuntimeError: a>' do
    RuntimeError.new('a').to_lookout_expected.difference(RuntimeError.new('b')).message
  end

  expect '(cannot inspect actual result: error)≠#<RuntimeError: a>' do
    stub(RuntimeError.new('b'), :inspect => proc{ raise 'error' }){ |b|
      RuntimeError.new('a').to_lookout_expected.difference(b).message
    }
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
    stub(RuntimeError.new('b'), :inspect => proc{ raise 'error' }){ |b|
      RuntimeError.new('a').to_lookout_expected.difference(b).message
    }
  end

  expect '(cannot inspect actual result: error)≉#<RuntimeError: /a/>' do
    stub(RuntimeError.new('b'), :inspect => proc{ raise 'error' }){ |b|
      RuntimeError.new(/a/).to_lookout_expected.difference(b).message
    }
  end
end
