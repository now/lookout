# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expected::Lookout::Actual::Not::Method.new(Lookout::Actual::Not::Method.new(:empty?)) do |o|
    Lookout::Actual::Not.new.to.be.empty?.to_lookout_expected
  end
end
