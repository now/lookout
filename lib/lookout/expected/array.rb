# -*- coding: utf-8 -*-

class Lookout::Expected::Array < Lookout::Expected::Object
  def =~(other)
    return false unless Array === other and @expected.size == other.size
    @expected.each_with_index do |v, i|
      return false unless v.to_lookout_expected =~ other[i]
    end
    true
  end

  def diff(other)
    return if @expected.size == 1 or not Array === other
    Lookout::Diff::Formats::Unified.
      new(Lookout::Diff::Groups.
            new(Lookout::Diff::Operations.
                  new(Lookout::Diff::Algorithms::Difflib.
                        new(other, @expected)))).to_a.join("\n")
  end
end
