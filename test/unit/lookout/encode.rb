# -*- coding: utf-8 -*-

Expectations do
  expect 'a' do
    a = 'a'
    class << a; undef encode end if a.respond_to? :encode
    Lookout::Encode.new(a).call
  end

  if 'a'.respond_to? :encode
    expect Encoding::UTF_8 do
      a = 'a'.force_encoding('ASCII-8BIT')
      Lookout::Encode.new(a).call.encoding
    end
  end
end
