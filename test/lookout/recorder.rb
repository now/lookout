# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Recorders::State do
    Lookout::Recorder.new([]).include? 1
  end

  expect NoMethodError do
    Lookout::Recorder.new([]).length
  end
end
