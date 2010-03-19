# -*- coding: utf-8 -*-

module Lookout::Results::Failures::State
  extend Lookout::Result

  is :failure

  def message
    return @message if instance_variable_defined? :@message and @message
    result = '%p≠%p' % [actual, expected]
    diff = Lookout::Utilities.diff(expected, actual)
    result << ': ' << diff if diff
    result
  end
end
