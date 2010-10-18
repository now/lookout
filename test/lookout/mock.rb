# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect 1 do
    Lookout::Mock.ing do
      Object.new.tap{ |o| mock(o).a{ 1 } }.a
    end
  end

  expect Lookout::Mock::Method::Calls::Error do
    Lookout::Mock.ing do
      mock(Object.new).a{ 1 }
    end
  end
end
