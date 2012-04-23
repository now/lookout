# -*- coding: utf-8 -*-

# Proxies objects that should be literally expected.  This is achieved by
# overriding #to_lookout_expected to wrap the object in a
# {Lookout::Expected::Object} instead of using whatever #to_lookout_expected on
# the object would normally return.  This allows us to expect a literal {Range}
# instead of allowing either a Range or an item included in the range.
class Lookout::Literal
  # Proxies the _expected_ value, allowing it to be expected literally.
  # @param [Object] expected
  Value(:expected)

  def inspect
    'literal(%p)' % output
  end

  # @return [Expected::Object] An expected value wrapper around the expected
  #   value
  def to_lookout_expected
    Lookout::Expected::Object.new(@expected)
  end
end
