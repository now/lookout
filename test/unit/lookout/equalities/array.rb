# -*- coding: utf-8 -*-

Expectations do
  expect false do
    Lookout::Equality.equal? %w[abc], nil
  end

  expect false do
    Lookout::Equality.equal? %w[abc], []
  end

  expect true do
    Lookout::Equality.equal? %w[abc], %w[abc]
  end

  expect true do
    Lookout::Equality.equal? [Integer], [1]
  end

  expect nil do
    Lookout::Equality.diff(%w[abc], %w[def])
  end

  expect nil do
    Lookout::Equality.diff(%w[abc], 'def')
  end

  expect <<EOD.chomp do
@@ -1,2 +1,2 @@
-def
+abc
 ghi
EOD
    Lookout::Equality.diff(%w[abc ghi], %w[def ghi])
  end
end
