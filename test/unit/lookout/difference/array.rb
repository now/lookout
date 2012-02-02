# -*- coding: utf-8 -*-

Expectations do
  # TODO: Move these tests to Difference::Array
  expect [] do
    %w[abc].to_lookout_expected.difference(%w[def]).diff
  end

  expect [] do
    %w[abc].to_lookout_expected.difference('def').diff
  end

  expect [<<EOD.chomp] do
@@ -1,2 +1,2 @@
-def
+abc
 ghi
EOD
    %w[abc ghi].to_lookout_expected.difference(%w[def ghi]).diff.to_a
  end
end
