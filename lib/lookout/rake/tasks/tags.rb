# -*- coding: utf-8 -*-

class Lookout::Rake::Tasks::Tags < Rake::TaskLib
  def initialize(specification = Lookout::Rake::Tasks.specification!)
    @specification = specification
    yield self if block_given?
    define
  end

  def define
    require 'rbtags/rake/tasks'
    RbTags::Rake::Tasks::Tags.new specification.require_paths, specification.lib_files.sort
  end

  attr_reader :specification
end
