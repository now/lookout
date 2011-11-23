# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Calls::Error do
    r = Lookout::Recorders::Reception::Not.new(Object.new, :a)
    Lookout::Mock.methods do |mocks|
      r.subject!(mocks).a
      r.verify
    end
    nil
  end

  expect nil do
    r = Lookout::Recorders::Reception::Not.new(Object.new, :a)
    Lookout::Mock.methods do |mocks|
      r.subject!(mocks)
      r.verify
    end
    nil
  end
end
