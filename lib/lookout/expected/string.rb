# -*- coding: utf-8 -*-

class Lookout::Expected::String < Lookout::Expected::Object
  def diff(other)
    return unless String === other
    (subject.include? "\n" or other.include? "\n") ?
     Lookout::Diff::Formats::Unified.
       new(Lookout::Diff::Groups.
             new(Lookout::Diff::Operations.
                   new(Lookout::Diff::Algorithms::Difflib.
                         new(other.split("\n"),
                             subject.split("\n"))))).to_a.join("\n") :
     Lookout::Diff::Formats::Inline.
       new(Lookout::Diff::Operations.
             new(Lookout::Diff::Algorithms::Difflib.new(other, subject))).to_s
  end
end
