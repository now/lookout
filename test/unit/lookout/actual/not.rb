# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Actual do
    Lookout::Actual::Not.new.not
  end

  expect Lookout::Actual::Not do Lookout::Actual::Not.new.to end

  expect Lookout::Actual::Not do Lookout::Actual::Not.new.to.be end

  expect Lookout::Actual::Not do Lookout::Actual::Not.new.to.have end

  expect Lookout::Actual::Not do Lookout::Actual::Not.new.to.be.empty? end

  expect Lookout::Expected::Lookout::Actual::Not.new(Lookout::Actual::Methods.new.push(:empty?)) do |o|
    Lookout::Actual::Not.new.to.be.empty?.to_lookout_expected
  end
end
