# -*- coding: utf-8 -*-

Expectations do
  expect '*args, &block' do
    Lookout::Mock::Method::Arguments::Any.new.inspect
  end

  expect true do
    Lookout::Mock::Method::Arguments::Any.new =~ []
  end

  expect true do
    Lookout::Mock::Method::Arguments::Any.new =~ [1, 2, 3]
  end

  expect [Lookout::Mock::Method::Arguments::Any] do
    Lookout::Mock::Method::Arguments::Any.new.to_a
  end
end
