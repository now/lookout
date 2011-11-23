# -*- coding: utf-8 -*-

module Lookout::Object
end

class Object
  def to
    Lookout::Object::To.new(self)
  end

  def not
    Lookout::Object::Not.new(self)
  end
end
