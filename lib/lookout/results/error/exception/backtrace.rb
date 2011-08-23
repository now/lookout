# -*- coding: utf-8 -*-

class Lookout::Results::Error::Exception::Backtrace
  def initialize(backtrace, trim, filter = ENV['LOOKOUT_DO_NOT_FILTER_BACKTRACE'].nil?)
    @backtrace = case backtrace
                 when nil then []
                 when String then [backtrace]
                 when Array then backtrace.select{ |l| String === l }
                 end
    @trim, @filter = trim, filter
  end

  def to_s
    trim(backtrace.map{ |location| "\tfrom %s" % location }).join("\n")
  end

private

  def backtrace
    return @backtrace unless @filter
    before or outside or @backtrace
  end

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
