# -*- coding: utf-8 -*-

class Lookout::Expectations::Warning < Lookout::Expectations::Object
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
    super(Lookout::Warning.new(@output.read))
  end
end
