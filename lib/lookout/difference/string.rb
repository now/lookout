# -*- coding: utf-8 -*-

class Lookout::Difference::String < Lookout::Difference::Object
  def diff
    return super unless String === actual
    (actual.include? "\n" or expected.include? "\n") ?
      Lookout::Diff::Formats::Unified.
        new(Lookout::Diff::Groups.
              new(Lookout::Diff::Operations.
                    new(Lookout::Diff::Algorithms::Difflib.
                          new(actual.split("\n"), expected.split("\n"))))) :
      Lookout::Diff::Formats::Inline.
        new(Lookout::Diff::Operations.
              new(Lookout::Diff::Algorithms::Difflib.
                    new(actual, expected)))
  end
end
