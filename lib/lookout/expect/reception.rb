# -*- coding: utf-8 -*-

class Lookout::Expect::Reception < Lookout::Expect::Object
  def call
    Lookout::Mock::Methods.with_verification do |methods|
      @expected.define(methods)
      evaluate_block
    end
    Lookout::Results::Success.new(file, line)
  rescue Lookout::Mock::Error => e
    Lookout::Results::Failures::Behavior.new(file, line, e.message)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
