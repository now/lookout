# -*- coding: utf-8 -*-

class Lookout::Expectations
  def initialize(results = Lookout::Results.new)
    @results = results
    @context = Context.new(self)
  end

  def load(path)
    method = Lookout::Stub::Method.new(Kernel, :Expectations){ |&block|
      evaluate(&block)
    }.define
    begin
      Kernel.load File.expand_path(path)
      self
    rescue SyntaxError => e
      raise unless matches = %r{\A(.*?:\d+): (.*)}m.match(e.message)
      raise SyntaxError, matches[2], [matches[1]] + e.backtrace
    ensure
      method.undefine
    end
  rescue Exception => e
    raise unless error(e)
  end

  def evaluate(&block)
    @context.instance_eval(&block)
    self
  rescue Exception => e
    raise unless error(e)
  end

  def <<(expectation)
    @results << expectation.evaluate
    self
  end

  private

  def error(e)
    case e
    when Interrupt, NoMemoryError, SignalException, SystemExit
      false
    else
      return false unless location = (Array(e.backtrace).first rescue nil)
      file, line = Lookout.location(location)
      return false unless file and line
      @results << Lookout::Results::Error.new(file, line, nil, e)
      true
    end
  end
end
