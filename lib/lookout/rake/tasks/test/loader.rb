# -*- coding: utf-8 -*-

require 'lookout'

only_load = false
ARGV.each do |arg|
  begin
    if not only_load and arg == '--'
      only_load = true
    elsif not only_load and arg =~ /\A-r(.*)/
      require $1
    else
      load arg
    end
  rescue SyntaxError => e
    raise e unless matches = %r{\A(.*?:\d+): (.*)}m.match(e.message)
    raise SyntaxError, matches[2], [matches[1]]
  end
end
