# -*- coding: utf-8 -*-

# Difference reports between {::Symbol}s.
class Lookout::Difference::Symbol < Lookout::Difference::Object
  # Initializes a difference report between the _actual_ result Symbol and the
  # _expected_ value Symbol, with _query_ being the name of the query method
  # that _expected_ represents, if any, whose result may be _negated_.
  # @param (see Object#initialize)
  # @param [::String, nil] query
  # @param [Boolean] negated
  def initialize(actual, expected, query, negated)
    super actual, expected
    @query, @negated = query, negated
  end

  # @return [::String, super] A String of the form {#actual}#_query_, prefixed
  #   by ‘¬’ if the query was negated, if there was a query, {super} otherwise
  def message
    @query ? [@negated ? '' : '¬', inspect_actual, '#', @query].join('') : super
  end
end
