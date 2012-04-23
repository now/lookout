# -*- coding: utf-8 -*-

# Represents expected {::Symbol}s.  A Symbol that’s suffixed by “?” is
# considered to be a query to be invoked on the actual result.  If such a
# symbol is prefixed by “not_”, the result of the query is inversed.
class Lookout::Expected::Symbol < Lookout::Expected::Object
  def initialize(expected)
    super
    @negated, @query = /\A(?:(not)_)?(?:(.+\?)|.*)\z/m.match(expected.to_s)[1..2]
  end

  # @param [::Symbol, ::Object] actual
  # @return [Difference::Symbol, nil] A difference report between _actual_ and
  #   {#expected} if {#expected} is a query and the result of the query doesn’t
  #   equal what’s expected, {super} otherwise
  def difference(actual)
    return super if not @query or Symbol === actual or actual.method(@query).arity != 0
    Lookout::Difference::Symbol.new(actual, expected, @query, @negated) unless
      (not not actual.send(@query)) ^ !!@negated
  end
end
