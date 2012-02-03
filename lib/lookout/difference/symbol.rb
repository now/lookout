# -*- coding: utf-8 -*-

class Lookout::Difference::Symbol < Lookout::Difference::Object
  def initialize(actual, expected, query, negated)
    super actual, expected
    @query, @negated = query, negated
  end

  def message
    @query ? '%s%s#%s' % [@negated ? '' : '¬', inspect_actual, @query] : super
  end
end
