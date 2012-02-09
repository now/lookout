# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Actual do
    Lookout::Actual::Not.new.not
  end

  expect Lookout::Expected::Lookout::Actual::Not.new(Lookout::Actual::Methods.new.push(:empty?)) do |o|
    Lookout::Actual::Not.new.to.be.empty?.to_lookout_expected
  end
end
