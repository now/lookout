# -*- coding: utf-8 -*-

# Represents expected {::Symbol}s.  A Symbol that’s suffixed by “?” is
# considered to be a query to be invoked on the actual result.  If such a
# symbol is prefixed by “not_”, the result of the query is inversed.
class Lookout::Expected::Symbol < Lookout::Expected::Object
  def initialize(subject)
    super
    @negated, @query = /\A(?:(not)_)?(?:(.+\?)|.*)\z/m.match(subject.to_s)[1..2]
  end

  # @param [::Symbol, ::Object] other
  # @return [Lookout::Difference::Symbol, nil] A difference report generator
  #   between _other_ and {#subject}, if {#subject} is a query and the result
  #   of the query doesn’t equal what’s expected
  # @extension
  def difference(other)
    return super unless @query
    Lookout::Difference::Symbol.new(other, subject, @query, @negated) unless
      (not not other.send(@query)) ^ !!@negated
  end
end
