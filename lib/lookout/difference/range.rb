# -*- coding: utf-8 -*-

# Generates difference reports between {::Range}s.  The report differs from
# that of {Object} in that it uses ‘∉’ instead of ‘≠’ to show that the actual
# result isn’t a member of the expected Range.
class Lookout::Difference::Range < Lookout::Difference::Object
  private

  # @return [::String] The symbol ‘∉’ unless {#actual} is a Range
  # @extension
  def symbol
    Range === actual ? super : '∉'
  end
end
