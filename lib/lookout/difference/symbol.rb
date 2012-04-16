# -*- coding: utf-8 -*-

# Difference reports between {::Symbol}s.
class Lookout::Difference::Symbol < Lookout::Difference::Object
  # @param (see Object#diff)
  # @param [::String, nil] query The name of the query method, if any
  # @param [Boolean] negated True if the result of the query method was negated
  def initialize(actual, expected, query, negated)
    super actual, expected
    @query, @negated = query, negated
  end

  # @return [::String] A String of the form {#actual}#_query_, prefixed by ‘¬’
  #   if the query was negated, if there was a query
  # @extension
  def message
    @query ? '%s%s#%s' % [@negated ? '' : '¬', inspect_actual, @query] : super
  end
end
