# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State::Error.new('expected true to be nil?') do
    Lookout::Recorders::State::Be.new(true).nil?.subject!(nil).last.call
  end

  expect true do
    Lookout::Recorders::State::Be.new(nil).nil?.subject!(nil).last.call
  end

  expect Lookout::Recorders::State::Error.new('expected (cannot inspect subject: error) to be nil?') do
    Lookout::Recorders::State::Be.new(stub(:nil? => false, :inspect => proc{ raise 'error' })).nil?.subject!(nil).last.call
  end
end
