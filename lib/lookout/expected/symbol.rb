# -*- coding: utf-8 -*-

class Lookout::Expected::Symbol < Lookout::Expected::Object
  def initialize(subject)
    super
    @negated, @query = /\A(?:(not)_)?(?:(.+\?)|.*)\z/m.match(subject.to_s)[1..2]
  end

  def difference(other)
    return super unless @query
    Lookout::Difference::Symbol.new(other, subject, @query, @negated) unless
      (not not other.send(@query)) ^ !!@negated
  end
end
