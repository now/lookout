# -*- coding: utf-8 -*-

# Proxies a method for later invocation.  The method information is stored and
# used when this method is {#call}ed, which sends it along to the given
# subject.
class Lookout::Actual::Method
  # @param [Symbol] name The method’s name
  # @param [Object, …] *args The argument to pass in
  # @param [Proc] &block The block to pass in
  def initialize(name, *args, &block)
    @name, @args, @block = name, args, block
  end

  # @param [Object] subject
  # @return [Object] The result of invoking the method with the given arguments
  #   on _subject_
  def call(subject)
    subject.__send__(name, *args, &block)
  end

  # @param [Lookout::Actual::Method] other
  # @return [Boolean] True if the receiver’s class, name, args, and block `#==`
  #   those of _other_
  def ==(other)
    self.class == other.class and
      name == other.name and
      args == other.args and
      block == other.block
  end

  def to_s
    '#%s%s%s' % [name,
                 args.empty? ? '' : '(%s)' % Lookout::Inspect::Argument.list(*args),
                 block ? '{ … }' : '']
  end

  # @return [Lookout::Expected::Lookout::Actual::Method] An expected value
  #   wrapper of the receiver
  def to_lookout_expected
    Lookout::Expected::Lookout::Actual::Method.new(self)
  end

  alias inspect to_s

  protected

  attr_reader :name, :args, :block
end
