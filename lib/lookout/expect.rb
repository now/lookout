# -*- coding: utf-8 -*-

module Lookout::Expect
  class << self
    def actualize(subject, file, line, &block)
      begin
        subject.to_lookout_expected
      rescue NoMethodError
        Lookout::Expected::Object.new(subject)
      end.actualize(file, line, &block)
    end
  end
end
