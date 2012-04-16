# -*- coding: utf-8 -*-

# Represents the “Expectations” keyword in expectation files and the
# expectation files themselves.  It’s used by {Rake::Tasks::Test} and
# should be used by other interfaces as the main access point to expectation
# files.  It’s implemented as an Enumerable over the expect blocks found in any
# of the expectations blocks in the expectation file.
class Lookout::Expectations
  include Enumerable

  @@expectations = {}

  class << self
    def load(path)
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

  # @param [String] path The expanded path of the expectations file
  def initialize(path)
    @path = path
  end

  # @overload
  #   Enumerates the expect blocks.
  #
  #   @yieldparam [Expect::Object] expect
  #   @return [self]
  #   @raise [NoMemoryError, SignalException, SystemExit] If raised; all other
  #     exceptions are caught and turned into failing expect blocks, located at
  #     the source of the exception
  # @overload
  #   @return [Enumerator] An Enumerator over the expect blocks
  def each
    return enum_for(__method__) unless block_given?
    context = Lookout::Expectations::Context.new{ |expect| yield expect }
    self.class.load(@path).each do |expectations|
      context.instance_eval(&expectations)
    end
    self
  rescue NoMemoryError, SignalException, SystemExit
    raise
  rescue Exception => e
    raise unless location = (Array(e.backtrace).first rescue nil)
    file, line = Lookout.location(location)
    raise unless file and line
    yield nil.to_lookout_expected.expect(file, line){ raise e }
    self
  end
end
