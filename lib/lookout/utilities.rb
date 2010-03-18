# -*- coding: utf-8 -*-

module Lookout::Utilities
  def self.diff(a, b)
    return unless a.is_a? String and b.is_a? String
    return a unless index = (0..a.size).find{ |i| a[i] != b[i] }
    run = a[index + 1..-1] == b[index + 1..-1] ? 1 : a.size - index
    '%s[%s|%s]%s' % [a[0, index], a[index, run], b[index, run], a[index + run..-1]]
  end
end
