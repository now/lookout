# -*- coding: utf-8 -*-

# Difference reports between {::Symbol}s.
class Lookout::Difference::Symbol < Lookout::Difference::Object
  # Initializes a difference report between the ACTUAL result Symbol and the
  # EXPECTED value Symbol, with QUERY being the name of the query method
  # that EXPECTED represents, if any, whose result may be NEGATED.
  # @param (see Object#initialize)
  # @param [::String, nil] query
  # @param [Boolean] negated
  def initialize(actual, expected, query, negated)
    super actual, expected
    @query, @negated = query, negated
  end

  # @return [::String, super] A String of the form {#actual}#QUERY, prefixed
  #   by ‘¬’ if the query was negated, if there was a query, {super} otherwise
  def message
    @query ? [@negated ? '' : '¬', inspect_actual, '#', @query].join('') : super
  end
end
