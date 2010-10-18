# -*- coding: utf-8 -*-

class Lookout::Mock::Object < Lookout::Aphonic
  def to
    Lookout::Recorder.new(self)
  end

  def not
    Lookout::Not.new(self)
  end
=begin
  def method_missing(method, *args, &block)
    # TODO: Report unexpected invocation errors.
  end
=end
end
