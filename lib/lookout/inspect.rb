# -*- coding: utf-8 -*-

class Lookout::Inspect
  def initialize(object, type)
    @object, @type = object, type
  end

  def call
    (inspection = inspect_object).encode('UTF-8')
  rescue => e
    begin
      dump = 'dumping instead: %s' % [inspection.dump]
    rescue => inner
      dump = 'dumping also failed: %s' % [output_error(inner)]
    end
    '(cannot encode inspected %s for output: %s; %s)' %
      [@type, output_error(e), dump]
  end

  private

  def inspect_object
    @object.inspect.to_s
  rescue => e
    '(cannot inspect %s: %s)' % [@type, output_error(e)]
  end

  def output_error(error)
    error.to_s.encode('UTF-8')
  rescue => e
    begin
      inner = e.to_s.encode('UTF-8')
    rescue
      inner = 'and cannot output error message for that error either; giving up'
    end
    'cannot output error message: %s' % [inner]
  end
end
