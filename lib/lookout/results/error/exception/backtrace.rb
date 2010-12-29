# -*- coding: utf-8 -*-

class Lookout::Results::Error::Exception::Backtrace
  def initialize(backtrace, filter = ENV['LOOKOUT_DO_NOT_FILTER_BACKTRACE'].nil?)
    @filter = filter
    @backtrace = case backtrace
                 when nil then []
                 when String then [backtrace]
                 when Array then backtrace.select{ |l| String === l }
                 end
  end

  def backtrace
    return @backtrace unless @filter
    before or outside or @backtrace
  end

  def to_s
    backtrace.map{ |location| "\tfrom %s" % location }.join("\n")
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

  Root = 4.times.reduce(__FILE__){ |path, _| File.dirname(path) }
end
