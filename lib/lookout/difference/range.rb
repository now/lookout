# -*- coding: utf-8 -*-

# Difference reports between {::Range}s.  The report differs from
# that of {Object} in that it uses ‘∉’ instead of ‘≠’ to show that the actual
# result isn’t a member of the expected Range.
class Lookout::Difference::Range < Lookout::Difference::Object
  # @return [::String, super] The symbol ‘∉’ unless {#actual} is a Range, {super}
  #   otherwise
  private; def symbol; Range === actual ? super : '∉' end
end
