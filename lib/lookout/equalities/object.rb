# -*- coding: utf-8 -*-

class Lookout::Equalities::Object
  Lookout::Equality.register self, Object

  def equal?(expected, actual)
    expected == actual
  end

  def message(expected, actual)
    format = format(expected, actual)
    return format unless diff = diff(expected, actual)
    (diff.include?("\n") ? "%s\n%s" : '%s: %s') % [format, diff]
  end

  def diff(expected, actual)
  end

private

  def format(expected, actual)
    '%p≠%p' % [actual, expected]
  end
end
