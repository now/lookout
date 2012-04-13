# -*- coding: utf-8 -*-

# Represents a successful result.  Used when the actual result of an expect
# block exhibits no differences from the expected value.
class Lookout::Results::Success
  include Lookout::Result
end
