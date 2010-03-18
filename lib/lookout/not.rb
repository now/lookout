# -*- coding: utf-8 -*-

class Lookout::Not
  private(*instance_methods.select{ |name| name !~ /(^__|^\W|^binding$)/ })

  def initialize(subject)
    @subject = subject
  end

  def method_missing(name, *args, &block)
    @subject.send(name, *args, &block).not!
  end
end
