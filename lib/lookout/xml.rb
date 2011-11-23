# -*- coding: utf-8 -*-

class Lookout::XML < String
  def ==(other)
    not normalize(other).index(normalize).nil?
  end

  def inspect
    'xml(%s)' % [normalize]
  end

  private

  def normalize(xml = self)
    xml.strip.gsub(/>\s*</, '><')
  end
end
