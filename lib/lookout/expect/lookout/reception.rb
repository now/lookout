# -*- coding: utf-8 -*-

class Lookout::Expect::Lookout::Reception < Lookout::Expect::Object
  def call
    Lookout::Mock::Methods.during do |methods|
      @expected.define(methods)
      evaluate_block
    end
    Lookout::Results::Success.new(file, line)
  rescue Lookout::Mock::Method::Calls::TooFewError => e
    Lookout::Results::Failure.new(file,
                                  line,
                                  Lookout::Difference::Lookout::Reception.
                                    new(e.calls, e.range, e.message))
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
