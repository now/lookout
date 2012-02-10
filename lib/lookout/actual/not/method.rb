# -*- coding: utf-8 -*-

class Lookout::Actual::Not::Method < Lookout::Actual::Method
  def to_lookout_expected
    Lookout::Expected::Lookout::Actual::Not::Method.new(self)
  end
end
