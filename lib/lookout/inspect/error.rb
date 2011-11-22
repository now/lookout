# -*- coding: utf-8 -*-

class Lookout::Inspect::Error
  def initialize(error)
    @error = error
  end

  def call
    encode(message)
  end

  private

  def message
    String(@error)
  rescue => e
    'cannot retrieve error message: %s' %
      encode((String(e) rescue
              'and cannot retrieve error message for error that generated that error either; giving up'))
  end

  def encode(message)
    message.encode('UTF-8')
  rescue => e
    'cannot encode error message for output: %s%s' %
      [(String(e).encode('UTF-8') rescue
        'and cannot encode error message for error that generated that error for output either; giving up'),
       ('; dumping instead: %s' % [message.dump] rescue '')]
  end
end
