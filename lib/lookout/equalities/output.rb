# -*- coding: utf-8 -*-

class Lookout::Equalities::Output < Lookout::Equalities::Object
  Lookout::Equality.register self, Lookout::Output

  def equal?(expected, _actual)
    expected.expected == expected.actual
  end

  def diff(expected, _actual)
    Lookout::Equality.diff(expected.expected, expected.actual)
  end

private

  def format(expected, _actual)
    '%p≠%p' % [Lookout::Output.new(expected.actual), expected]
  end
end
