# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    Lookout::Expected::Lookout::State.new(nil, proc{ true }).difference(:unused)
  end

  expect nil do
    Lookout::Expected::Lookout::State.new(nil, proc{ false }).difference(:unused)
  end
end
