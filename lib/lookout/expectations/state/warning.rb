# -*- coding: utf-8 -*-

class Lookout::Expectations::State::Warning < Lookout::Expectations::State
  def evaluate
    @output = StringIO.new
    saved_stderr = $stderr
    $stderr = @output
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

  private

  def check(actual)
    @output.rewind
    super(@output.read)
  end
end
