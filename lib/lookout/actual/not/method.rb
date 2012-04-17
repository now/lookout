# -*- coding: utf-8 -*-

# (see Lookout::Actual::Method)
class Lookout::Actual::Not::Method < Lookout::Actual::Method
  # @return [Expected::Lookout::Actual::Not::Method] An expected value wrapper
  #   of the receiver
  def to_lookout_expected
    Lookout::Expected::Lookout::Actual::Not::Method.new(self)
  end
end
