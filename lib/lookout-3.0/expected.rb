# -*- coding: utf-8 -*-

# Function-like namespace for type-specific expected values.  Every {::Object}
# should be convertable to a {Lookout::Expected::Object} when it receives
#  #to_lookout_expected.  ::Object implements this method, so all objects are
# covered by default.  If you have a type that would benefit from more specific
# treatment, implement #to_lookout_expected by returning an instance of a
# subclass {Lookout::Expected::Object}.
module Lookout::Expected
end
