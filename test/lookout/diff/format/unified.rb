# -*- coding: utf-8 -*-

require 'lookout'

Expectations do
  expect '' do
    Lookout::Diff::Format::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithm::Difflib.
                        new(%w[one two three],
                            %w[one two three])))).to_a.join("\n")
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
    Lookout::Diff::Format::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithm::Difflib.
                        new(%w[one two three four],
                            %w[zero one tree four])))).to_a.join("\n")
  end

  expect <<EOD.chomp do
@@ -1,4 +1,4 @@
-two
+too
 1
 2
 3
EOD
    Lookout::Diff::Format::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithm::Difflib.
                        new(%w[two 1 2 3 4 5 6 7 8],
                            %w[too 1 2 3 4 5 6 7 8])))).to_a.join("\n")
  end
end
