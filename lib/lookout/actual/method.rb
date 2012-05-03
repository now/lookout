# -*- coding: utf-8 -*-

# Proxies a method for later invocation on the actual result.  The method
# information is stored and used when this method is {#call}ed, which passes it
# along to the given actual result.
class Lookout::Actual::Method
  # Proxies _method_, passing in _args_ and _block_ when {#call}ed.
  # @param [Symbol] method
  # @param [Object, …] args
  # @param [Proc] block
  Value(:method, :'*args', :'&block')

  # @param [Object] actual
  # @return [Object] The result of invoking the method with the given arguments
  #   on the _actual_ result
  def call(actual)
    actual.__send__(method, *args, &block)
  end

  # @return [Expected::Lookout::Actual::Method] An expected value wrapper of
  #   the receiver
  def to_lookout_expected
    Lookout::Expected::Lookout::Actual::Method.new(self)
  end

  # @return A string of the form “#_method_(_args_){ … }”, depending on if any
  #   arguments or block has been given
  def to_s
    '#%s%s%s' % [method,
                 args.empty? ? '' : '(%s)' % Lookout::Inspect::Argument.list(*args),
                 block ? '{ … }' : '']
  end

  alias inspect to_s
end
