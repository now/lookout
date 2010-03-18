# -*- coding: utf-8 -*-

class Lookout::XmlString < String
  def ==(other)
    not Regexp.new(Regexp.escape(normalize(self))).match(normalize(other)).nil?
  end

  def inspect
    "[as xml] #{normalize(self)}"
  end

  protected

  def normalize(xml_string)
    xml_string.strip.gsub(/>\s*</, "><")
  end

end
