# -*- coding: utf-8 -*-

Expectations do
  expect RuntimeError.new('error') do
    Lookout::Encode.new(stub(:to_str => proc{ raise 'error' })).call
  end

  expect 'a' do
    a = 'a'
    class << a; undef encode end if a.respond_to? :encode
    Lookout::Encode.new(a).call
  end

  expect 'a' do
    a = 'a'
    class << a; def respond_to?(m); raise 'error' end end
    Lookout::Encode.new(a).call
  end

  if 'a'.respond_to? :encode
    expect Encoding::UTF_8 do
      a = 'a'.force_encoding('ASCII-8BIT')
      Lookout::Encode.new(a).call.encoding
    end
  end
end
