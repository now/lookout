# -*- coding: utf-8 -*-

Expectations do
  expect true do
    Lookout::Equality.equal? true, true
  end

  expect false do
    Lookout::Equality.equal? true, false
  end

  expect false do
    Lookout::Equality.equal? false, true
  end

  expect true do
    Lookout::Equality.equal? false, false
  end

  expect false do
    Lookout::Equality.equal? true, nil
  end

  expect true do
    Lookout::Equality.equal? true, 1
  end

  expect true do
    Lookout::Equality.equal? false, nil
  end

  expect false do
    Lookout::Equality.equal? false, 1
  end

  expect true do
    Lookout::Equality.equal? true, stub(:== => proc{ raise 'error' })
  end

  expect false do
    Lookout::Equality.equal? false, stub(:== => proc{ raise 'error' })
  end
end
