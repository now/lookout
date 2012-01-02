# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::State::Recording.new.record(:length).record(:==, 0).play_for([])
  end

  expect false do
    Lookout::State::Recording.new.record(:length).record(:==, 1).play_for([])
  end

  expect 'length == 0' do
    Lookout::State::Recording.new.record(:length).record(:==, 0).to_s
  end

  expect 'one? { … }' do
    Lookout::State::Recording.new.record(:one?){ true }.to_s
  end

  expect 'one? 1 { … }' do
    Lookout::State::Recording.new.record(:one?, 1){ true }.to_s
  end
end
