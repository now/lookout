# -*- coding: utf-8 -*-

# Represents the “Expectations” keyword in expectation files and the
# expectation files themselves.  Used by {Rake::Tasks::Test} and should be used
# by other interfaces as the main access point to expectation files.
# Implemented as an Enumerable over the expect blocks found in any of the
# expectations blocks in the expectation file.
class Lookout::Expectations
  # Prepares the enumeration of the expect blocks found in the expectations
  # file pointed to by the expanded _path_.
  # @param [String] path
  Value(:path)
  include Enumerable

  @@expectations = {}

  class << self
    def load(path)
      @@expectations[path] = []
      begin
        begin
          Kernel.load path, true
        rescue LoadError => e
          raise e,
            'cannot load expectations from file: %s' % e.message,
            [(Array(e.backtrace).find{ |b| b.start_with? path } or '%s:0' % path)] +
              Array(e.backtrace) unless e.message.end_with? path
          raise e,
            'cannot load expectations from file: no such file or directory',
            ['%s:0' % path]
        rescue SyntaxError => e
          raise unless matches = (/\A(.*?:\d+): (.*)/m.match(e.message) rescue nil)
          raise SyntaxError, matches[2], [matches[1]] + Array(e.backtrace)
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
    self.class.load(path).each do |expectations|
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
