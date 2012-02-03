# -*- coding: utf-8 -*-

class Lookout::Expectations
  include Enumerable

  @@expectations = {}

  class << self
    def load(path)
      # TODO: Should wait for @@expectations[path] to be unset.
      @@expectations[path] = []
      begin
        begin
          Kernel.load path, true
        rescue LoadError => e
          raise e, 'cannot load expectations from file: %s: no such file or directory' % path
        rescue SyntaxError => e
          raise unless matches = /\A(.*?:\d+): (.*)/m.match(e.message)
          raise SyntaxError, matches[2], [matches[1]] + e.backtrace
        end
        @@expectations[path]
      ensure
        @@expectations.delete path
      end
    end

    def evaluate(path, &block)
      @@expectations[path] << block
      self
    end
  end

  def initialize(path)
    @path = path
  end

  def each
    return enum_for(__method__) unless block_given?
    context = Lookout::Expectations::Context.new{ |expect| yield expect }
    self.class.load(@path).each do |expectations|
      context.instance_eval(&expectations)
    end
    self
  rescue Interrupt, NoMemoryError, SignalException, SystemExit
    raise
  rescue Exception => e
    raise unless location = (Array(e.backtrace).first rescue nil)
    file, line = Lookout.location(location)
    raise unless file and line
    # TODO: raise unless file == @path?
    yield nil.to_lookout_expected.expect(file, line){ raise e }
    self
  end
end
