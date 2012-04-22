# -*- coding: utf-8 -*-

# Expect block of {Expected::Lookout::Warning}s.
class Lookout::Expect::Lookout::Warning < Lookout::Expect::Object
  private

  # @return [Lookout::Warning] A warning object wrapping the output generated
  #   on a temporary IO object that replaces `$stderr` during the evaluation of
  #   the {super expect block} while `$VERBOSE` has been set to true
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
          @expected.expected.class.new(output.string)
        ensure
          $VERBOSE = saved_verbose
        end
      ensure
        $stderr = saved_stderr
      end
    end
  end
end
