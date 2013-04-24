# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Results::Success.new('test', 1) do
    'a'.to.receive.call.once.to_lookout_expected.expect('test', 1){ |o| o.call }.call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Reception.
          new(0,
              Lookout::Reception.of('a', :call).once)) do
    'a'.to.receive.call.once.to_lookout_expected.expect('test', 1).call
  end

  expect Lookout::Results::Failure.
    new('test',
        1,
        Lookout::Difference::Lookout::Reception.
          new(0,
              Lookout::Reception.of('a', :call).once)) do
    'a'.to.receive.call.once.to_lookout_expected.expect('test', 1){ }.call
  end
end
