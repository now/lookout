# -*- coding: utf-8 -*-

class Lookout::Encode
  def initialize(string)
    @string = string
  end

  def call
    string = String(@string)
    return string unless (string.respond_to?(:encode) rescue true)
    string.encode('UTF-8')
  end
end
