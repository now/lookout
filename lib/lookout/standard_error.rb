# -*- coding: utf-8 -*-

class Lookout::StandardError
  def self.silence
    $VERBOSE = nil
  end

  def self.print(string)
    print_suggestion
    warn string
  end

  def self.print_suggestion
    return if @suggestion_printed
    @suggestion_printed = true
    warn "Lookout allows you to to create multiple mock expectations, but suggests that you write another test instead.\n"
  end
end
