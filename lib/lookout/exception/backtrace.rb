# -*- coding: utf-8 -*-

# Provides non-failing access to an exception backtrace.  The backtrace entries
# are {Encode}d for output and the backtrace may be filtered to not include
# entries from inside Lookout.
class Lookout::Exception::Backtrace
  class << self
    # @param [::Exception] exception
    # @return [Backtrace] A backtrace wrapper of _exception_’s backtrace,
    #   trimmed if _exception_ is a SystemStackError, and empty if the
    #   backtrace can’t be retrieved
    def from(exception)
      new(nil == exception ? nil : (exception.backtrace rescue nil),
          SystemStackError === exception)
    end
  end

  # Wraps _backtrace_ and optionally _trim_ the backtrace to only contain a
  # couple of leading and trailing entries and _filter_ out entries from inside
  # Lookout.
  # @param [Array<String>] backtrace
  # @param [Boolean] trim
  # @param [Boolean] filter
  def initialize(backtrace, trim, filter = ENV['LOOKOUT_DO_NOT_FILTER_BACKTRACE'].nil?)
    @backtrace = if nil == backtrace
                   []
                 elsif String === backtrace or Array === backtrace
                   (String === backtrace ? [backtrace] : backtrace).map{ |line|
                     begin
                       Lookout::Encode.new(line).call
                     rescue => e
                       '(cannot retrieve backtrace entry: %s)' %
                         Lookout::Exception.new(e).message
                     end
                   }
                 else
                   ['(backtrace is not an Array of String: %s)' %
                      Lookout::Inspect.new(backtrace, 'backtrace').call]
                 end
    @trim, @filter = trim, filter
  end

  # @return [String] The concatenation of the backtrace entries
  def to_s
    trim(backtrace.map{ |location| "\tfrom %s" % location }).join("\n")
  end

  def inspect
    '%p.new(%p, %p, %p)' % [self.class, @backtrace, @trim, @filter]
  end

  # @param [Backtrace] other
  # @return [Boolean] True if the receiver’s class, backtrace, and trim and
  #   filter settings `#==` those of _other_
  def ==(other)
    self.class == other.class and backtrace == other.backtrace
  end

  alias eql? ==

  def hash
    backtrace.hash
  end

  protected

  def backtrace
    return @backtrace unless @filter
    before or outside or @backtrace
  end

  private

  def before
    nilify(@backtrace.take_while{ |location| not reject? location })
  end

  def outside
    nilify(@backtrace.reject{ |location| reject? location })
  end

  def nilify(backtrace)
    backtrace.empty? ? nil : backtrace
  end

  def reject?(location)
    location.start_with? Root
  end

  def trim(locations)
    return locations unless @trim and locations.length > Head + Tail + 5
    locations[0...Head] +
      ["\t ... %d levels ..." % (locations.length - Head - Tail)] +
      locations[-Tail..-1]
  end

  Root = 4.times.reduce(__FILE__){ |path, _| File.dirname(path) }
  Head = 8
  Tail = 5
end
