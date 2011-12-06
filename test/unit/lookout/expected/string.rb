# -*- coding: utf-8 -*-

Expectations do
  expect nil do
    'abc'.to_lookout_expected.diff(1)
  end

  expect '[-A-]{+a+}bc' do
    'abc'.to_lookout_expected.diff('Abc')
  end

  expect 'a[-B-]{+b+}c' do
    'abc'.to_lookout_expected.diff('aBc')
  end

  expect 'ab[-C-]{+c+}' do
    'abc'.to_lookout_expected.diff('abC')
  end

  expect <<EOD.chomp do
@@ -1,1 +1,2 @@
+abc
 ghi
EOD
    "abc\nghi".to_lookout_expected.diff('ghi')
  end

  expect <<EOD.chomp do
@@ -1,2 +1,1 @@
-def
 ghi
EOD
    'ghi'.to_lookout_expected.diff("def\nghi")
  end

  expect <<EOD.chomp do
@@ -1,2 +1,2 @@
-def
+abc
 ghi
EOD
    "abc\nghi".to_lookout_expected.diff("def\nghi")
  end
end
