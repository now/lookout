# -*- coding: utf-8 -*-

# Difference reports between {::Regexp}s.  The report differs from that of
# {Object} in that it uses ‘≉’ instead of ‘≠’ to show that the actual result
# doesn’t match the expected Regexp.
class Lookout::Difference::Regexp < Lookout::Difference::Object
  # @return [::String, super] The symbol ‘≉’ unless {#actual} is a Regexp,
  #   {super} otherwise
  private; def symbol; Regexp === actual ? super : '≉' end
end
