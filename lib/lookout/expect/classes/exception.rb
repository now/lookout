# -*- coding: utf-8 -*-

class Lookout::Expect::Classes::Exception < Lookout::Expect::Object
  def call
    begin
      result = evaluate_block
    rescue @expected.subject
      return Lookout::Results::Success.new(file, line)
    rescue Exception => e
      return Lookout::Results::Error.
        new(file,
            line,
            @expected.difference(Lookout::Exception.new(e).type).message,
            e)
    end
    check(result)
  rescue Exception => e
    Lookout::Results::Error.new(file, line, nil, e)
  end
end
