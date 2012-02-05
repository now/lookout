# -*- coding: utf-8 -*-

class Lookout::Expected::Symbol < Lookout::Expected::Object
  def initialize(subject)
    super
    @negated, @query = /\A(?:(not)_)?(?:(.+\?)|.*)\z/m.match(subject.to_s)[1..2]
  end

  def difference(other)
    @query ?
      (!!other.send(@query) ^ !!@negated ?
       nil :
       Lookout::Difference::Symbol.new(other, subject, @query, @negated)) :
      super
  end
end