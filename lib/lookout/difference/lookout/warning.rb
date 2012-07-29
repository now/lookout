# -*- coding: utf-8 -*-

# Difference reports between {::Lookout::Warning}s.
class Lookout::Difference::Lookout::Warning < Lookout::Difference::Lookout::Output
  # @return [::String] The inequality symbol ‘≉’
  private; def symbol; '≉' end
end
