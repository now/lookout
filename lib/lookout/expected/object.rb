# -*- coding: utf-8 -*-

# Represents expected {::Object}s.  This is the base expected-value class and
# may be subclassed if you have a type that would benefit from more specific
# treatment than what this class affords.  Such a subclass should override
# {#expect} and/or {#difference} to set up type-specific expect blocks and/or
# difference checks and difference report generation.
class Lookout::Expected::Object
  # Wraps the _expected_ value.
  # @param [::Object] expected The expected value
  Value(:expected)
  public :expected

  # @param (see Expect::Object#initialize)
  # @yieldparam (see Expect::Object#initialize)
  # @yieldreturn (see Expect::Object#initialize)
  # @return [Expect::Object] An expect block for the receiver at _line_ in
  #   _file_ that’ll yield the {#expected} object and expect an object that’ll
  #   exhibit no {#difference}s from it to be returned
  def expect(file, line, &block)
    Lookout::Expect::Object.new(self, file, line, &block)
  end

  # @param [::Object] actual
  # @return [Difference::Object, nil] A difference report between _actual_ and
  #   {#expected} unless they’re `#==`
  def difference(actual)
    Lookout::Difference::Object.new(actual, expected) unless expected == actual
  end
end
