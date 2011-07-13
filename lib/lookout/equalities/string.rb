# -*- coding: utf-8 -*-

class Lookout::Equalities::String < Lookout::Equalities::Object
  Lookout::Equality.register self, String

  def diff(expected, actual)
    return unless String === actual
    (expected.include? "\n" or actual.include? "\n") ?
     Lookout::Diff::Formats::Unified.
       new(Lookout::Diff::Groups.
             new(Lookout::Diff::Operations.
                   new(Lookout::Diff::Algorithms::Difflib.
                         new(actual.split("\n"),
                             expected.split("\n"))))).to_a.join("\n") :
     Lookout::Diff::Formats::Inline.
       new(Lookout::Diff::Operations.
             new(Lookout::Diff::Algorithms::Difflib.new(actual, expected))).to_s
  end
end
