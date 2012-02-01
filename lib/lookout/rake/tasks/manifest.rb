# -*- coding: utf-8 -*-

class Lookout::Rake::Tasks::Manifest < Rake::TaskLib
  def initialize(options = {})
    self.manifest = options.fetch(:manifest, Lookout::Rake::Tasks.manifest)
    yield self if block_given?
    define
  end

  def define
    raise 'No manifest specificed' unless @manifest

    desc 'Check that the manifest is correct'
    task :"manifest:check" do
      unknown = Dir['{lib,test/unit}/**/*.rb'] -
        @manifest.lib_files -
        @manifest.unit_test_files
      fail unknown.map{ |e| 'file not included in manifest: %s' % e }.join("\n") unless unknown.empty?
    end

    task :check => :"manifest:check"
  end

  attr_writer :manifest
end
