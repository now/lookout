# -*- coding: utf-8 -*-

require 'lookout'

failed = false
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
    file = File.expand_path(arg)
    expectations = Lookout::Expectations.new(file)
    if line
      target = nil.to_lookout_expected.actualize(file, line){
        raise RuntimeError, 'line expectation not found: %s:%d' % [file, line]
      }
      [(expectations.take_while{ |expect| expect <= target }.last or target)]
    else
      expectations
    end.each do |expect|
      result = expect.call
      next if Lookout::Results::Success === result
      failed = true
      $stderr.puts result
    end
  end
end
exit false if failed
