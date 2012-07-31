# -*- coding: utf-8 -*-

# Difference reports between {::Lookout::Warning}s.
class Lookout::Difference::Lookout::Warning < Lookout::Difference::Lookout::Output
  private

  # @return [::String] The inequality symbol ‘≉’
  def symbol; '≉' end
end
