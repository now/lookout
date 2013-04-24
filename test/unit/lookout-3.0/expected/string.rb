# -*- coding: utf-8 -*-

Expectations do
  expect [] do
    'abc'.to_lookout_expected.difference(1).diff
  end

  expect '[-A-]{+a+}bc' do
    'abc'.to_lookout_expected.difference('Abc').diff.to_s
  end

  expect 'a[-B-]{+b+}c' do
    'abc'.to_lookout_expected.difference('aBc').diff.to_s
  end

  expect 'ab[-C-]{+c+}' do
    'abc'.to_lookout_expected.difference('abC').diff.to_s
  end

  expect <<EOD.chomp do
@@ -1,1 +1,2 @@
+abc
 ghi
EOD
    "abc\nghi".to_lookout_expected.difference('ghi').diff.to_s
  end

  expect <<EOD.chomp do
@@ -1,2 +1,1 @@
-def
 ghi
EOD
    'ghi'.to_lookout_expected.difference("def\nghi").diff.to_s
  end

  expect <<EOD.chomp do
@@ -1,2 +1,2 @@
-def
+abc
 ghi
EOD
    "abc\nghi".to_lookout_expected.difference("def\nghi").diff.to_s
  end
end
