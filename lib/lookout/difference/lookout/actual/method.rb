# -*- coding: utf-8 -*-

# Difference reports between {::Lookout::Actual::Method}s.
class Lookout::Difference::Lookout::Actual::Method < Lookout::Difference::Object
  # @return [::String] A String of the form ¬{#actual}#{#expected}, where
  #   {#actual} is the object that the query method {#expected} was invoked upon
  def message; [symbol, inspect_actual, inspect_expected].join('') end

  private

  # @return [::String] The inequality symbol ‘¬’
  def symbol; '¬' end
end
