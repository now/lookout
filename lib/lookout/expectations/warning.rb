# -*- coding: utf-8 -*-

class Lookout::Expectations::Warning < Lookout::Expectations::Object
  private

  def evaluate_in_context
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
