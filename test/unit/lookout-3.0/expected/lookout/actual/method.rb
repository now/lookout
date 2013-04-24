# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    Lookout::Actual.new.empty?.to_lookout_expected.difference([])
  end

  expect Lookout::Difference::Lookout::Actual::Method.new([1], Lookout::Actual::Method.new(:empty?)) do
    Lookout::Actual.new.empty?.to_lookout_expected.difference([1])
  end
end
