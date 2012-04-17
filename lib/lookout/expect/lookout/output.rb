# -*- coding: utf-8 -*-

# Expect block of {Expected::Lookout::Output}s.
class Lookout::Expect::Lookout::Output < Lookout::Expect::Object
  private

  # @return [Lookout::Output] The output generated on an IO object passed to
  #   the expect block as the expected value during the evaluation of that
  #   block
  # @extension
  def evaluate_block
    output = StringIO.new
    super output
    @expected.expected.class.new(output.string)
  end
end
