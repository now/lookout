# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Lookout::State.new('expected true to be nil?') do
    Lookout::State::Be.new(true).nil?.to_lookout_expected.difference(:unused)
  end

  expect nil do
    Lookout::State::Be.new(nil).nil?.to_lookout_expected.difference(:unused)
  end

  expect Lookout::Difference::Lookout::State.new('expected (cannot inspect subject: error) to be nil?') do
    Lookout::State::Be.new(stub(:nil? => false, :inspect => proc{ raise 'error' })).nil?.to_lookout_expected.difference(:unused)
  end
end
