# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1) ==
      Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1)
  end

  expect false do
    Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1) ==
      Lookout::Mock::Method::Calls::Exactly.new(:object, :method, 1).call
  end
end
