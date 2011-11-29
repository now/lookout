# -*- coding: utf-8 -*-

Expectations do
  expect false do
    Lookout::Equality.equal?({'a' => 1}, 'b')
  end

  expect false do
    Lookout::Equality.equal?({'a' => 1, 'b' => 2}, {'a' => 1})
  end

  expect false do
    Lookout::Equality.equal?({'a' => 1, 'b' => 2}, {'a' => 1, 'b' => 3})
  end

  expect true do
    Lookout::Equality.equal?({'a' => 1, 'b' => 2}, {'a' => 1, 'b' => 2})
  end

  expect true do
    Lookout::Equality.equal?({'a' => Integer, 'b' => 2}, {'a' => 1, 'b' => 2})
  end

  expect nil do
    Lookout::Equality.diff({'a' => 1}, {'b' => 1})
  end

  expect nil do
    Lookout::Equality.diff({'a' => 1}, 'b')
  end

  expect <<EOD.chomp do
-"g" => 1
+"c" => 1
EOD
    Lookout::Equality.diff({'c' => 1, 'b' => 2}, {'g' => 1, 'b' => 2})
  end
end
