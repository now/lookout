# -*- coding: utf-8 -*-

Expectations do
  expect '"v"' do
    Lookout::Inspect.new('v', 'value').call
  end

  expect '"v"' do
    '%s' % Lookout::Inspect.new('v', 'value')
  end

  expect '"v"' do
    [Lookout::Inspect.new('v', 'value')].join('')
  end

  if ''.respond_to? :encode
    expect Encoding::UTF_8 do
      Lookout::Inspect.new('v'.encode('ASCII-8BIT'), 'value').call.encoding
    end

    expect '(cannot inspect value: error)' do
      Lookout::Inspect.new(stub(:inspect => proc{ raise 'error' }), 'value').call
    end

    expect '(cannot encode inspected value for output: "\xE2" from ASCII-8BIT to UTF-8; dumping instead: "can\xE2\x80\x99t")' do
      Lookout::Inspect.new(stub(:inspect => 'can’t'.force_encoding('ASCII-8BIT')), 'value').call
    end

    expect '(cannot encode inspected value for output: "\xE2" from ASCII-8BIT to UTF-8; dumping also failed: error)' do
      stub('can’t'.force_encoding('ASCII-8BIT'), :dump => proc{ raise 'error' }){ |message|
        Lookout::Inspect.new(stub(:inspect => message), 'value').call
      }
    end
  end
end
