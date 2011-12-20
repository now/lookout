# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::State::Error.new('expected true to be nil?') do
    Lookout::State::Be.new(true).nil?.to_lookout_expected.verify
  end

  expect true do
    Lookout::State::Be.new(nil).nil?.to_lookout_expected.verify
  end

  expect Lookout::State::Error.new('expected (cannot inspect subject: error) to be nil?') do
    Lookout::State::Be.new(stub(:nil? => false, :inspect => proc{ raise 'error' })).nil?.to_lookout_expected.verify
  end
end
