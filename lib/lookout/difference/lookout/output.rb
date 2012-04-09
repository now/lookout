# -*- coding: utf-8 -*-

# Generates difference reports between {::Lookout::Output}s.
class Lookout::Difference::Lookout::Output < Lookout::Difference::Object
  # @return [Enumerable] The result of {::Lookout::Output#diff} on {#expected}
  #   against {#actual}
  def diff
    expected.diff(actual)
  end
end
