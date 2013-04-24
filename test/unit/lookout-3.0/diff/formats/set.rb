# -*- coding: utf-8 -*-

Expectations do
  expect '' do
    Lookout::Diff::Formats::Set.
      new(Lookout::Diff::Operations.
          new(Lookout::Diff::Algorithms::Difflib.
              new(['a => 1', 'b => 2', 'c => 3'],
                  ['a => 1', 'b => 2', 'c => 3']))).to_a.join("\n")
  end

  expect <<EOD.chomp do
-a => 1
-b => 2
-c => 3
+a => 0
+b => 1
+c => 2
EOD
    Lookout::Diff::Formats::Set.
      new(Lookout::Diff::Operations.
          new(Lookout::Diff::Algorithms::Difflib.
              new(['a => 1', 'b => 2', 'c => 3', 'd => 4'],
                  ['a => 0', 'b => 1', 'c => 2', 'd => 4']))).to_a.join("\n")
  end
end
