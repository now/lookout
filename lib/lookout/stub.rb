# -*- coding: utf-8 -*-

module Lookout::Stub
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
