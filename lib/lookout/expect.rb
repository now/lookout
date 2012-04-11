# -*- coding: utf-8 -*-

# This is a function-like namespace for type-specific expect blocks.  It
# represents the “expect” keyword in expectation files.  It’s used by
# {Expectations::Context}.
#
# {Object} is the base class for all classes defined under this namespace, so
# look to it for guidance.
module Lookout::Expect
  class << self
    # Wraps the creation of an {Object} or one of its sub-classes by
    # dispatching #to_lookout_expected on the subject and then calling #expect
    # on the result.  If #to_lookout_expected raises NoMethodError, the result
    # will be an {Object}, so that at least something is set up.
    # @param [::Object] subject The test subject (the expected value)
    # @param [::String] file The expanded path to the file containing the
    #   expectation
    # @param [::Integer] line The line in _file_ on which the expectation is
    #   defined
    # @param [Proc] &block The block to evaluate for the actual result
    # @return [Object] The result of calling
    #   _subject_#to_lookout_expected#expect
    def expect(subject, file, line, &block)
      begin
        subject.to_lookout_expected
      rescue ::NoMethodError
        ::Lookout::Expected::Object.new(subject)
      end.expect(file, line, &block)
    end
  end
end
