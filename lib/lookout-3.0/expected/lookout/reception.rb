# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Reception}s.  This is used to check mock
# method invocation counts and arguments.
class Lookout::Expected::Lookout::Reception < Lookout::Expected::Object
  # @param (see Object#expect)
  # @yieldparam (see Object#expect)
  # @yieldreturn (see Object#expect)
  # @return [Expect::Object] An expect block for the receiver at LINE in FILE
  #   that’ll yield the {#expected} object and expect the block to call the
  #   method the appropriate number of times
  def expect(file, line, &block)
    super file, line, &expected.block(&block)
  end

  # @param [Integer] actual
  # @return [Difference::Lookout::Reception, nil] A difference report between
  #   the ACTUAL number of times the method was received and the range of
  #   expected number of receptions unless the earlier lay within the latter
  def difference(actual)
    Lookout::Difference::Lookout::Reception.
      new(actual, expected) unless expected.range === actual
  end
end
