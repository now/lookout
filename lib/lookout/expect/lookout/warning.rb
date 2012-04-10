# -*- coding: utf-8 -*-

# Represents the expect block of {Expected::Lookout::Warning}s.
class Lookout::Expect::Lookout::Warning < Lookout::Expect::Object
  private

  # Evaluates the expect block with `$stderr` redirected to a temporary IO
  # object and `$VERBOSE` set to true.
  # @return [Lookout::Warning] A warning object with the output generated on
  #   the IO object during the evaluation of the expect block
  # @extension
  def evaluate_block
    output = StringIO.new
    saved_stderr = $stderr
    begin
      $stderr = output
      saved_verbose = $VERBOSE
      begin
        $VERBOSE = true
        begin
          super
          @expected.subject.class.new(output.string)
        ensure
          $VERBOSE = saved_verbose
        end
      ensure
        $stderr = saved_stderr
      end
    end
  end
end
