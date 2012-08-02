# -*- coding: utf-8 -*-

Expectations do
  expect %r'≠' do
    {'a' => 1}.to_lookout_expected.difference('b').message
  end

  expect %r'≠' do
    {'a' => 1, 'b' => 2}.to_lookout_expected.difference({'a' => 1}).message
  end

  expect %r'≉' do
    {'a' => 1, 'b' => 2}.to_lookout_expected.difference({'a' => 1, 'b' => 3}).message
  end

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
