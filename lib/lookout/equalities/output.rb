# -*- coding: utf-8 -*-

class Lookout::Equalities::Output < Lookout::Equalities::Object
  Lookout::Equality.register self, Lookout::Output

  def equal?(expected, _)
    expected.expected == expected.actual
  end

  def diff(expected, _)
    Lookout::Equality.diff(expected.expected, expected.actual)
  end

  private

  def format(expected, _)
    '%p≠%p' % [Lookout::Output.new(expected.actual), expected]
  end
end
