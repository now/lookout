# -*- coding: utf-8 -*-

# Difference reports between {::Array}s.
class Lookout::Difference::Array < Lookout::Difference::Object
  # @return [Diff::Formats::Unified] A unified “diff” between {#actual} and
  #   {#expected} unless {#expected} contains one element or {#actual} isn’t an
  #   Array.
  # @extension
  def diff
    return super if expected.size == 1 or not Array === actual
    Lookout::Diff::Formats::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithms::Difflib.
                        new(actual, expected))))
  end
end
