# -*- coding: utf-8 -*-

Expectations do
  expect [0, 2] do
    result = []
    Lookout::Diff::Algorithms::Difflib::Position::To.
      new(%w[a b a]).each_index('a') do |index|
      result << index
    end
    result
  end
end
