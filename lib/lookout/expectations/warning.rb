# -*- coding: utf-8 -*-

class Lookout::Expectations::Warning < Lookout::Expectations::Output
  def evaluate
    saved_stderr = $stderr
    $stderr = subject
    begin
      saved_verbose = $VERBOSE
      $VERBOSE = true
      begin
        super
      ensure
        $VERBOSE = saved_verbose
      end
    ensure
      $stderr = saved_stderr
    end
  end
end
