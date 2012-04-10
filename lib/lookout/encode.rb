# -*- coding: utf-8 -*-

# Encodes an object as a UTF-8-encoded String.  This is done by calling String
# with the object as the argument and then calling #encode on the result, if
# the result responds to it.  This is primarily useful for compatibility
# between Ruby 1.8 and 1.9.
class Lookout::Encode
  # @param [#to_s] string Object to encode
  def initialize(string)
    @string = string
  end

  # @return [String] An UTF-8-encoded String representation of the object
  def call
    string = String(@string)
    return string unless (string.respond_to?(:encode) rescue true)
    string.encode('UTF-8')
  end
end
