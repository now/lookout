# -*- coding: utf-8 -*-

# Difference reports between {::Module}s.  The report differs from that of
# {Object} in that it uses ‘≉’ instead of ‘≠’ to show that the actual result
# isn’t an instance of (doesn’t case match) the expected Module.
class Lookout::Difference::Module < Lookout::Difference::Object
  # @return [::String, super] The symbol ‘≉’ unless {#actual} is a Module,
  #   {super} otherwise
  private; def symbol; Module === actual ? super : '≉' end
end
