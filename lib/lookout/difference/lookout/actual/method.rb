# -*- coding: utf-8 -*-

# Generates difference reports between {::Lookout::Actual::Method}s.
class Lookout::Difference::Lookout::Actual::Method < Lookout::Difference::Object
  # @return [::String] A String of the form ¬{#actual}#_query_
  def message
    [symbol, inspect_actual, inspect_expected].join('')
  end

  private

  # @return [::String] The inequality symbol ‘¬’
  def symbol
    '¬'
  end
end
