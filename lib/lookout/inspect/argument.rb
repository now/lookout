# -*- coding: utf-8 -*-

class Lookout::Inspect::Argument < Lookout::Inspect
  class << self
    def list(*arguments)
      arguments.map{ |e| Lookout::Inspect::Argument.new(e).call }.join(', ')
    end
  end

  def initialize(argument)
    super argument, 'argument'
  end
end
