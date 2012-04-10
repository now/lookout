# -*- coding: utf-8 -*-

# Represents the expect block of {Expected::Lookout::Output}s.
class Lookout::Expect::Lookout::Output < Lookout::Expect::Object
  private

  # Evaluates the expect block with an IO object as the test subject.
  # @return [::String] The output generated on the IO object during the
  #   evaluation of the expect block
  # @extension
  def evaluate_block
    output = StringIO.new
    super output
    @expected.subject.class.new(output.string)
  end
end
