# -*- coding: utf-8 -*-

require 'lookout'

results = Lookout::Results.new
failed = Lookout::Results::Trackers::Failure.new(results)
expectations = Lookout::Expectations.new(results)
ui = Lookout::UI::Console.new(results)
line = nil
only_load = false
ARGV.each do |arg|
  if not only_load and arg == '--'
    only_load = true
  elsif not only_load and arg =~ /\A-r(.*)/
    require $1
  elsif not only_load and arg =~ /\A-l(.*)/
    line = $1.to_i
  else
    (line ?
     Lookout::Expectations::Line.new(results, File.expand_path(arg), line) :
     expectations).load arg
  end
end
ui.flush
exit false if failed.failed?
