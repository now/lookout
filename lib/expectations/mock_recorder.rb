class Expectations::MockRecorder
  attr_accessor :target
  def initialize(target, method=nil)
    self.target = target
    events << MockEvent.new(:expects, [method]) unless method.nil?
  end
  
  def to_receive(method)
    events << MockEvent.new(:expects, [method])
    self
  end
  
  def events
    @events ||= []
  end
  
  def method_missing(method, *args)
    super if events.empty?
    events << MockEvent.new(method, args)
    self
  end
  
  def mock
    events.inject(target) do |result, element|
      result.send(element.method, *element.args)
    end
    target
  end
  
  def verify
    target.verify
  end
  
  class MockEvent
    attr_accessor :method, :args
    def initialize(method, args)
      self.method, self.args = method, args
    end
  end
end