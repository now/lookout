# -*- coding: utf-8 -*-

Expectations do
  expect 'arg' do
    Lookout::Mock::Method::Arguments::Anything.new.inspect
  end

  expect true do
    Lookout::Mock::Method::Arguments::Anything.new == 1
  end

  expect true do
    Lookout::Mock::Method::Arguments::Anything.new == nil
  end
end
