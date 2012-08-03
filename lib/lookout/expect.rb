# -*- coding: utf-8 -*-

# Function-like namespace for type-specific expect blocks.  Represents the
# “expect” keyword in expectation files.  Used by {Expectations::Context}.
#
# {Object} is the base class for all classes defined under this namespace, so
# look to it for guidance.
module Lookout::Expect
  class << self
    # Wraps the creation of an {Object} or one of its sub-classes by
    # dispatching #to_lookout_expected on the _expected_ value and then calling
    #  #expect on the result, passing the expanded path to the FILE
    # containing the expectation, the LINE in _file_ on which the expectation
    # is defined, and the BLOCK to evaluate for the actual result.
    #
    # If #to_lookout_expected raises NoMethodError, the result will be an
    # {Object}, so that at least something gets set up.
    #
    # @param [::Object] expected
    # @param [::String] file
    # @param [::Integer] line
    # @return [Object] The result of calling
    #   _expected_#to_lookout_expected#expect(FILE, LINE, &BLOCK)
    def expect(expected, file, line, &block)
      begin
        expected.to_lookout_expected
      rescue ::NoMethodError
        ::Lookout::Expected::Object.new(expected)
      end.expect(file, line, &block)
    end
  end
end
