# -*- coding: utf-8 -*-

class Lookout::Mock::Object < Lookout::Aphonic
  def method_missing(method, *args, &block)
    # TODO: Report unexpected invocation errors.
  end
end
