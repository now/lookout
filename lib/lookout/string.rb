# -*- coding: utf-8 -*-

class String
  def diff(other)
    (0..self.size).inject("") do |result, index|
      if self[index, 1] == other[index, 1]
        result += self[index, 1]
      else
        result += "[#{self[index, 1]}|#{other[index, 1]}], mismatch at index #{index}\n"
        result += "Trailing expected: <#{self[index+1, self.size - index]}>\n"
        result += "Trailing actual: <#{other[index+1, other.size - index]}>"
        return result
      end
      result
    end
  end
end
