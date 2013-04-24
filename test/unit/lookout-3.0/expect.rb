# -*- coding: utf-8 -*-

Expectations do
  expect Lookout::Expect::Exception do
    Lookout::Expect.expect(StandardError.new, 'test', 1)
  end

  expect NoMethodError do
    Lookout::Aphonic.new.to_lookout_expected
  end

  expect Lookout::Expect::Object do
    Lookout::Expect.expect(Lookout::Aphonic.new, 'test', 1)
  end
end
