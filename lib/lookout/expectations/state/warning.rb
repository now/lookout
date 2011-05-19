# -*- coding: utf-8 -*-

require 'stringio'

class Lookout::Expectations::State::Warning < Lookout::Expectations::State
  def evaluate_with_stubs
    @output = StringIO.new
    saved_stderr = $stderr
    $stderr = @output
    begin
      with_verbose do
        super
      end
    ensure
      $stderr = saved_stderr
    end
  end

private

  def check(actual)
    @output.rewind

    super @output.read
  end
end
