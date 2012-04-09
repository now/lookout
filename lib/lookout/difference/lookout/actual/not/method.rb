# -*- coding: utf-8 -*-

# Generates difference reports between {::Lookout::Actual::Not::Method}s.
class Lookout::Difference::Lookout::Actual::Not::Method < Lookout::Difference::Lookout::Actual::Method
  private

  # @return [::String] The inequality symbol ‘’
  def symbol
    ''
  end
end
