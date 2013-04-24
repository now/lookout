# -*- coding: utf-8 -*-

# Proxies a method for later invocation on the actual result.  The method
# information is stored and used when this method is {#call}ed, which passes it
# along to the given actual result.
class Lookout::Actual::Not::Method < Lookout::Actual::Method
  # @return [Expected::Lookout::Actual::Not::Method] An expected value wrapper
  #   of the receiver
  def to_lookout_expected; Lookout::Expected::Lookout::Actual::Not::Method.new(self) end
end
