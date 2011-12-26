# -*- coding: utf-8 -*-

Expectations do
  expect Enumerator do
    Lookout::Expectations.new(nil).each
  end

  expect [Lookout::Expect::Object] do
    stub(Lookout::Expectations).load{ proc{ expect 1 do 1 end } }
    Lookout::Expectations.new(nil).entries
  end

  expect [Lookout::Results::Error] do
    stub(Lookout::Expectations).load{ proc{ this_method_is_not_defined } }
    Lookout::Expectations.new(nil).map(&:call)
  end
end
