# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Undefined.new(Object.new,
                                              :method,
                                              Lookout::Mock::Method::Calls::Exactly.new(0),
                                              1, 2, 3){ } do |o|
    o.define.undefine
  end
end
