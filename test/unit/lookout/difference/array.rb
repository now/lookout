# -*- coding: utf-8 -*-

Expectations do
  expect '1≠[1]' do
    [1].to_lookout_expected.difference(1).message
  end

  expect '[1]≠[1, 2]' do
    [1, 2].to_lookout_expected.difference([1]).message
  end

  expect '[1, 3]≉[1, 2]' do
    [1, 2].to_lookout_expected.difference([1, 3]).message
  end

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
