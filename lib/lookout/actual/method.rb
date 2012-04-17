# -*- coding: utf-8 -*-

# Proxies a method for later invocation on the actual result.  The method
# information is stored and used when this method is {#call}ed, which passes it
# along to the given actual result.
class Lookout::Actual::Method
  # Proxies _method_, passing in _args_ and _block_ when {#call}ed.
  # @param [Symbol] method
  # @param [Object, …] *args
  # @param [Proc] &block
  def initialize(method, *args, &block)
    @method, @args, @block = method, args, block
  end

  # @param [Object] actual
  # @return [Object] The result of invoking the method with the given arguments
  #   on the _actual_ result
  def call(actual)
    actual.__send__(method, *args, &block)
  end

  # @param [Actual::Method] other
  # @return [Boolean] True if the receiver’s class, method, args, and block
  #   `#==` those of _other_
  def ==(other)
    self.class == other.class and
      method == other.method and
      args == other.args and
      block == other.block
  end

  def to_s
    '#%s%s%s' % [method,
                 args.empty? ? '' : '(%s)' % Lookout::Inspect::Argument.list(*args),
                 block ? '{ … }' : '']
  end

  # @return [Expected::Lookout::Actual::Method] An expected value wrapper of
  #   the receiver
  def to_lookout_expected
    Lookout::Expected::Lookout::Actual::Method.new(self)
  end

  alias inspect to_s

  protected

  attr_reader :method, :args, :block
end
