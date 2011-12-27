# -*- coding: utf-8 -*-

Expectations do
  expect 'error' do
    Lookout::Inspect::Error.new(RuntimeError.new('error')).call
  end

  expect "cannot retrieve error message: error" do
    Lookout::Inspect::Error.new(stub(:to_str => proc{ raise 'error' })).call
  end

  expect "cannot retrieve error message: can't convert Lookout::Stub::Object to String (Lookout::Stub::Object#to_s gives NilClass)" do
    Lookout::Inspect::Error.new(stub(:to_str => nil, :to_s => nil)).call
  end

  if ''.respond_to? :encode
    expect 'cannot encode error message for output: "\xE2" from ASCII-8BIT to UTF-8; dumping instead: "can\xE2\x80\x99t"' do
      Lookout::Inspect::Error.new(stub(:to_str => 'can’t'.force_encoding('ASCII-8BIT'))).call
    end

    expect 'cannot encode error message for output: "\xE2" from ASCII-8BIT to UTF-8' do
      message = 'can’t'.force_encoding('ASCII-8BIT')
      stub(message).dump{ raise 'error' }
      Lookout::Inspect::Error.new(stub(:to_str => message)).call
    end
  end
end
