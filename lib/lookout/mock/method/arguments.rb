# -*- coding: utf-8 -*-

# Arguments that should be passed to the mock method.  Sets things up based on
# what kind of arguments were passed to it and may then be used to {#verify}
# that arguments that don’t {Lookout::Difference differ} from them are
# subsequently passed to the mock method.
class Lookout::Mock::Method::Arguments
  # Sets up the expected _args_ to a mock method.  If _args_ is #empty?, {Any}
  # will be used.  If _args_ contains an {Any} or a {None}, they’ll be used.
  # Otherwise, _args_ will be wrapped in a {List}.  @param [Object, …] *args
  Value(:'*args')
  def initialize(*args)
    @args = if args.empty? then Any.new
            elsif any = args.find{ |e| Any === e } then any
            elsif none = args.find{ |e| None === e } then none
            else List.new(*args)
            end
  end

  # Checks for {Lookout::Difference differences} between _args_ and the
  # expected ones.
  # @param [Object, …] *args
  # @raise [Error] If the passed _args_ differ from the expected ones.
  # @return [true]
  def verify(*args)
    self.args =~ args or
      raise Error, 'unexpected arguments ([%s]≠[%s])' % [List.new(*args), self.args]
  end

  # @return [String] The arguments as a String argument list
  def to_s
    (result = args.to_s).empty? ? result : '(%s)' % result
  end

  # @return [Object, Array<Object>] The expected arguments as an array
  def to_a
    args.to_a
  end
end
