# -*- coding: utf-8 -*-

# Difference reports between {::Lookout::Output}s.
class Lookout::Difference::Lookout::Output < Lookout::Difference::Object
  # @return [Enumerable<::String>] The result of
  #   {#expected}{::Lookout::Output#diff #diff}({#actual})
  def diff; expected.diff(actual) end
end
