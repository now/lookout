# -*- coding: utf-8 -*-

# Non-failing inspection of objects.  The inspection is {Lookout::Encode
# encoded} for output.
class Lookout::Inspect
  # Non-failing inspection of OBJECT, using TYPE as a description of the
  # type of object being inspected for failure outputs.
  # @param [Object] object
  # @param [String] type
  Value(:object, :type)

  class << self
    # @param [Object, …] args
    # @return [String] The inspections of ARGS, separated by “, ”’s
    def args(*args)
      args.map{ |e| Lookout::Inspect.new(e, 'argument') }.join(', ')
    end
  end

  # @return [String] An UTF-8-encoded String inspection of the given object,
  #   generated by invoking #inspect on it, then {Lookout::Encode encoding} it
  #   as UTF-8, using #dump if any transcoding that may take place fails
  def call
    Lookout::Encode.new(inspection = inspect_object).call
  rescue => e
    '(cannot encode inspected %s for output: %s; %s)' %
      [type,
       Lookout::Exception.new(e),
       begin
         'dumping instead: %s' % [inspection.dump]
       rescue => inner
         'dumping also failed: %s' % Lookout::Exception.new(inner)
       end]
  end

  alias to_s call

  private

  def inspect_object
    String(object.inspect)
  rescue => e
    '(cannot inspect %s: %s)' % [type, Lookout::Exception.new(e)]
  end
end