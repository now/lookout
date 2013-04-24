# -*- coding: utf-8 -*-

Expectations do
  expect [] do
    'a'.to_lookout_expected.difference(1).diff
  end

  expect '[-b-]{+a+}' do
    'a'.to_lookout_expected.difference('b').diff.to_s
  end

  expect <<EOF.chomp do
@@ -1,2 +1,1 @@
-b
-c
+a
EOF
    'a'.to_lookout_expected.difference("b\nc").diff.to_s
  end

  expect <<EOF.chomp do
@@ -1,1 +1,2 @@
-c
+a
+b
EOF
    "a\nb".to_lookout_expected.difference("c").diff.to_s
  end
end
