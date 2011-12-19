# -*- coding: utf-8 -*-

class Lookout::Expect::Reception < Lookout::Expect::Object
  def call
    Lookout::Mock.methods do |mocks|
      mock = @expected.mock(mocks)
      evaluate_block
      mock.verify
    end
    Lookout::Results::Fulfilled.new(file, line)
  rescue Lookout::Mock::Error => e
    Lookout::Results::Failures::Behavior.new(file, line, e.message)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
