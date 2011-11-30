# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    Lookout::Equality.diff('abc', 1)
  end

  expect '[-A-]{+a+}bc' do
    Lookout::Equality.diff('abc', 'Abc')
  end

  expect 'a[-B-]{+b+}c' do
    Lookout::Equality.diff('abc', 'aBc')
  end

  expect 'ab[-C-]{+c+}' do
    Lookout::Equality.diff('abc', 'abC')
  end

  expect <<EOD.chomp do
@@ -1,1 +1,2 @@
+abc
 ghi
EOD
    Lookout::Equality.diff("abc\nghi", 'ghi')
  end

  expect <<EOD.chomp do
@@ -1,2 +1,1 @@
-def
 ghi
EOD
    Lookout::Equality.diff('ghi', "def\nghi")
  end

  expect <<EOD.chomp do
@@ -1,2 +1,2 @@
-def
+abc
 ghi
EOD
    Lookout::Equality.diff("abc\nghi", "def\nghi")
  end
end
