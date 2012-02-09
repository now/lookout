# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    Lookout::Actual.new.empty?.to_lookout_expected.difference([])
  end

  expect Lookout::Difference::Lookout::Actual.new([1], Lookout::Actual::Methods.new.push(:empty?)) do
    Lookout::Actual.new.empty?.to_lookout_expected.difference([1])
  end
end
