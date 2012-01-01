# -*- coding: utf-8 -*-

class Lookout::Expect::Lookout::Warning < Lookout::Expect::Object
  private

  def evaluate_block
    output = StringIO.new
    saved_stderr = $stderr
    $stderr = output
    begin
      saved_verbose = $VERBOSE
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
