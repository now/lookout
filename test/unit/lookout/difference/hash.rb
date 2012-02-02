# -*- coding: utf-8 -*-

Expectations do
  expect [] do
    {'a' => Integer}.to_lookout_expected.difference({'b' => 1}).diff
  end

  expect [] do
    {'a' => Integer}.to_lookout_expected.difference('b').diff
  end

  expect <<EOD.chomp do
-"g" => 1
+"c" => 1
EOD
    {'c' => 1, 'b' => 2}.to_lookout_expected.difference({'g' => 1, 'b' => 2}).diff.to_s
  end
end
