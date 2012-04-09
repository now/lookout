# -*- coding: utf-8 -*-

# Generates difference reports between {::String}s.
class Lookout::Difference::String < Lookout::Difference::Object
  # @return [super] Unless {#actual} is a String
  # @return [Lookout::Diff::Formats::Unified] A unified “diff” if {#actual} or
  #   {#expected} include a newline
  # @return [Lookout::Diff::Formats::Inline] An inline “diff” otherwise
  # @extension
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
