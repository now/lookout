# -*- coding: utf-8 -*-

# A failed result used when the actual result of an expect block exhibits
# differences from the expected value.
class Lookout::Results::Failure
  include Lookout::Result

  # (see Result#initialize)
  # The _difference_ report between the actual result and the expected value
  # will be used to display this information to the user.
  # @param [Difference::Object] difference
  Value(:file, :line, :difference, :comparable => [:file, :line])

  def to_s
    [super, difference].join(': ')
  end
end
