# -*- coding: utf-8 -*-

module Lookout::Results::Failures::State
  extend Lookout::Result

  is :failure

  def message
    return @message if instance_variable_defined? :@message and @message
    result = "%p≠%p" % [expected, actual]
    result += ":#{expected.diff(actual)}" if expected.is_a? String and actual.is_a? String
    result
  end
end
