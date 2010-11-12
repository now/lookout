# -*- coding: utf-8 -*-

Expectations do
  expect '' do
    Lookout::Diff::Formats::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithms::Difflib.
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
    Lookout::Diff::Formats::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithms::Difflib.
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
    Lookout::Diff::Formats::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithms::Difflib.
                        new(%w[two 1 2 3 4 5 6 7 8],
                            %w[too 1 2 3 4 5 6 7 8])))).to_a.join("\n")
  end

  expect <<EOD.chomp do
@@ -1,4 +1,4 @@
-two
+too
 1
 2
 3
@@ -7,4 +7,4 @@
 6
 7
 8
-one
+tre
EOD
    Lookout::Diff::Formats::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithms::Difflib.
                        new(%w[two 1 2 3 4 5 6 7 8 one],
                            %w[too 1 2 3 4 5 6 7 8 tre])))).to_a.join("\n")
  end
end
