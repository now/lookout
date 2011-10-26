# -*- coding: utf-8 -*-

module Lookout::Mock
  Error = Class.new(StandardError)

  class << self
    def methods
      methods = Methods.new
      begin
        yield methods
      ensure
        methods.undefine
      end
    end
  end
end
