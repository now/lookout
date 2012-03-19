# -*- coding: utf-8 -*-

require 'lookout'

failed = false
line = nil
only_load = false
pwd = Dir.pwd
ARGV.each do |arg|
  if not only_load and arg == '--'
    only_load = true
  elsif not only_load and arg =~ /\A-r(.*)/
    require $1
  elsif not only_load and arg =~ /\A-l(.*)/
    line = $1.to_i
  else
    file = File.expand_path(arg, pwd)
    expectations = Lookout::Expectations.new(file)
    if line
      target = nil.to_lookout_expected.expect(file, line){
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
end
exit false if failed
