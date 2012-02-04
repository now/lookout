# -*- coding: utf-8 -*-

class Lookout::Expected::Lookout::Reception < Lookout::Expected::Object
  def initialize(subject, method, calls, *args, &body)
    super subject
    @method, @calls, @args, @body = method, calls, args, body
  end

  def expect(file, line, &block)
    Lookout::Expect::Lookout::Reception.new(self, file, line, &block)
  end

  def difference(other)
    Lookout::Mock::Methods.during do |methods|
      methods.define(subject, @method, @calls, *@args, &@body)
      other.call
    end
    nil
  rescue Lookout::Mock::Method::Calls::TooFewError => e
    Lookout::Difference::Lookout::Reception.new(e.calls, e.range, e.message)
  end
end
