# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect '' do
    Lookout::Diff::Format::Unified.diff(%w(one two three),
                                        %w(one two three)).to_a.join("\n")
  end

  expect <<EOD.chomp do
@@ -1,4 +1,4 @@
+zero
 one
-two
-three
+tree
 four
EOD
    Lookout::Diff::Format::Unified.diff(%w(one two three four),
                                        %w(zero one tree four)).to_a.join("\n")
  end
end
