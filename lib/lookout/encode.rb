# -*- coding: utf-8 -*-

# Encodes objects as UTF-8-encoded Strings.  This is done by calling String
# with the object as the argument and then calling #encode on the result, if
# the result responds to it.  This is primarily useful for compatibility
# between Ruby 1.8 and 1.9.
class Lookout::Encode
  # Encodes _object_ as an UTF-8-encoded String.
  # @param [#to_s] object
  Value(:object)

  # @return [String] An UTF-8-encoded String representation of the object
  def call
    string = String(object)
    return string unless (string.respond_to?(:encode) rescue true)
    string.encode('UTF-8')
  end
end
