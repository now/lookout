# -*- coding: utf-8 -*-

require 'lookout'

line = nil
only_load = false
files = []
pwd = Dir.pwd
ARGV.each do |arg|
  if not only_load and arg == '--'
    only_load = true
  elsif not only_load and arg =~ /\A-r(.*)/
    require $1
  elsif not only_load and arg =~ /\A-l(.*)/
    line = $1.to_i
  else
    files << [arg, File.expand_path(arg, pwd)]
  end
end

failed = false
files.each do |file, expanded|
  expectations = Lookout::Expectations.new(expanded)
  if line
    target = nil.to_lookout_expected.expect(expanded, line){
      raise RuntimeError, 'line expectation not found: %s:%d' % [file, line]
    }
    [(expectations.take_while{ |expect| expect <= target }.last or target)]
  else
    expectations
  end.each do |expect|
    result = expect.call
    next if Lookout::Results::Success === result
    failed = true
    message = result.to_s
    $stderr.puts message.start_with?(pwd) ? message[pwd.length+1..-1] : message
  end
end

exit false if failed
