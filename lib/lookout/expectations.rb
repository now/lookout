# -*- coding: utf-8 -*-

class Lookout::Expectations
  def initialize(results = Lookout::Results.new)
    @results = results
    @context = Context.new(self)
  end

  def load(path)
    evaluate do
      begin
        load File.expand_path(path)
      rescue SyntaxError => e
        raise unless matches = %r{\A(.*?:\d+): (.*)}m.match(e.message)
        raise SyntaxError, matches[2], [matches[1]]
      end
    end
  end

  def evaluate(&block)
    @context.instance_eval(&block)
    self
  rescue Interrupt, NoMemoryError, SignalException, SystemExit
    raise
  rescue Exception => e
    raise unless location = (Array(e.backtrace).first rescue nil)
    file, line = Lookout.location(location)
    raise unless file and line
    @results << Lookout::Results::Error.new(file, line, nil, e)
  end

  def <<(expectation)
    @results << expectation.evaluate
    self
  end
end
