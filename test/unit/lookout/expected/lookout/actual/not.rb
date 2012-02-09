# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Difference::Lookout::Actual::Not.new([], Lookout::Actual::Methods.new.push(:empty?)) do
    Lookout::Actual.new.not.empty?.to_lookout_expected.difference([])
  end

  expect nil do
    Lookout::Actual.new.not.empty?.to_lookout_expected.difference([1])
  end
end
