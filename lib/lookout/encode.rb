# -*- coding: utf-8 -*-

# Encodes objects as UTF-8-encoded Strings.  This is done by calling String
# with the object as the argument and then calling #encode on the result, if
# the result responds to it.  This is primarily useful for compatibility
# between Ruby 1.8 and 1.9.
class Lookout::Encode
  # Encodes _object_ as an UTF-8-encoded String.
  # @param [#to_s] object
  def initialize(object)
    @object = object
  end

  # @return [String] An UTF-8-encoded String representation of the object
  def call
    string = String(object)
    return string unless (string.respond_to?(:encode) rescue true)
    string.encode('UTF-8')
  end

  # @param [Encode] other
  # @return [Boolean] True if the receiver’s class and object `#==` those of
  #   _other_
  def ==(other)
    self.class == other.class and object == other.object
  end

  alias eql? ==

  def hash
    object.hash
  end

  protected

  attr_reader :object
end
