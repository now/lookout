# -*- coding: utf-8 -*-

Expectations do
  expect [nil, nil] do
    Lookout.location('abc')
  end

  expect ['abc.rb', 123] do
    Lookout.location('abc.rb:123')
  end

  expect ['abc.rb', 123] do
    Lookout.location('abc.rb:123:in def')
  end

  expect [String, Integer] do
    Lookout.location(caller.first)
  end

  expect [__FILE__, __LINE__ + 2] do
    begin
      raise 'hell'
    rescue => e
      Lookout.location(e.backtrace.first)
    end
  end
end
