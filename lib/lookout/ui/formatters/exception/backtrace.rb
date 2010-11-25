# -*- coding: utf-8 -*-

class Lookout::UI::Formatters::Exception::Backtrace
  def initialize(backtrace, filter = ENV['LOOKOUT_DO_NOT_FILTER_BACKTRACE'].nil?)
    @backtrace, @filter = backtrace, filter
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
    location.rindex(Root, 0)
  end

  Root = 4.times.reduce(__FILE__){ |path, _| File.dirname(path) }
end