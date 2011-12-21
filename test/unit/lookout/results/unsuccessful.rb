# -*- coding: utf-8 -*-

Expectations do
  expect 0 do
    results = Lookout::Results::Unsuccessful.new
    results << Lookout::Results::Success.new(nil, 0)
    results.count
  end
end
