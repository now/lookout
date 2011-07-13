# -*- coding: utf-8 -*-

class Lookout::Equalities::Warning < Lookout::Equalities::String
  Lookout::Equality.register self, Lookout::Warning

  def equal?(expected, actual)
    expected == actual.chomp or
      actual =~ /\A.*?:\d+: warning: #{Regexp.escape(expected)}\Z/u
  end

private

  def format(expected, actual)
    '%p≠%p' % [Lookout::Warning.new(actual), expected]
  end
end
