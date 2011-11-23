# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Mock::Method::Calls::Error do
    r = Lookout::Recorders::Reception::Not.new(Object.new, :a)
    Lookout::Mock.methods do |mocks|
      subject, verify = r.subject!(mocks)
      subject.a
      verify.call
    end
    nil
  end

  expect nil do
    r = Lookout::Recorders::Reception::Not.new(Object.new, :a)
    Lookout::Mock.methods do |mocks|
      _, verify = r.subject!(mocks)
      verify.call
    end
    nil
  end
end
