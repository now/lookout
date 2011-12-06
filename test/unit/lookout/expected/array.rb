# -*- coding: utf-8 -*-

Expectations do
  expect false do
    %w[abc].to_lookout_expected =~ nil
  end

  expect false do
    %w[abc].to_lookout_expected =~ []
  end

  expect true do
    %w[abc].to_lookout_expected =~ %w[abc]
  end

  expect true do
    [Integer].to_lookout_expected =~ [1]
  end

  expect nil do
    %w[abc].to_lookout_expected.diff(%w[def])
  end

  expect nil do
    %w[abc].to_lookout_expected.diff('def')
  end

  expect <<EOD.chomp do
@@ -1,2 +1,2 @@
-def
+abc
 ghi
EOD
    %w[abc ghi].to_lookout_expected.diff(%w[def ghi])
  end
end
