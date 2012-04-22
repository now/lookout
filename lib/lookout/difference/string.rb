# -*- coding: utf-8 -*-

# Difference reports between {::String}s.
class Lookout::Difference::String < Lookout::Difference::Object
  # @return [Diff::Formats::Unified, Diff::Formats::Inline, super] A unified
  #   “diff” if {#actual} or {#expected} include a newline, an inline “diff”
  #   otherwise, or {super} if {#actual} isn’t a String
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
