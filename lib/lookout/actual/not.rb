# -*- coding: utf-8 -*-

class Lookout::Actual::Not < Lookout::Actual
  def not
    Lookout::Actual.new
  end

  def to_lookout_expected
    Lookout::Expected::Lookout::Actual::Not.new(@methods)
  end
end
