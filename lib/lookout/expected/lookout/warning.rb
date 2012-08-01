# -*- coding: utf-8 -*-

# Represents expected {::Lookout::Warning}s.
class Lookout::Expected::Lookout::Warning < Lookout::Expected::Object
  # @param (see Object#expect)
  # @yield
  # @yieldreturn [::Lookout::Warning]
  # @return [Expected::Output] An expect block for the receiver at _line_ in
  #   _file_ that’ll yield and expect the warning to be output to `$stderr`
  #   during the execution of the block
  def expect(file, line, &block)
    super(file, line){ |expected|
      with_global :$stderr, StringIO.new do
        with_verbose do
          block.call
          expected.class.new($stderr.string)
        end
      end
    }
  end

  # @param [::Lookout::Warning] actual
  # @return [Difference::Lookout::Warning, nil] A difference report between
  #   _actual_ and {#expected} unless they’re `#===`
  def difference(actual)
    Lookout::Difference::Lookout::Warning.new(actual, expected) unless
      expected === actual
  end
end
