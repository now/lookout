# -*- coding: utf-8 -*-

class Lookout::Equalities::Object
  Lookout::Equality.register self, Object

  def equal?(expected, actual)
    expected == actual
  end

  def message(expected, actual)
    begin
      format = format(expected, actual)
    rescue => e
      raise if Lookout::Equalities::Object == self.class rescue true
      return '%s (cannot generate more specific failure message: %s)' %
        [Lookout::Equalities::Object.new.message(expected, actual), e.message]
    end
    begin
      diff = diff(expected, actual)
    rescue => e
      diff = '(cannot diff expected value and actual result: %s)' % e.message
    end
    diff ? (diff.include?("\n") ? "%s\n%s" : '%s: %s') % [format, diff] : format
  end

  def diff(expected, actual)
  end

  private

  def format(expected, actual)
    '%s≠%s' % [Lookout::Inspect::Actual.new(actual).call,
               Lookout::Inspect::Expected.new(expected).call]
  end
end
