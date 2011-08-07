require 'bundler'
require 'rubygems'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ['--options', "spec/spec.opts"]
  t.pattern = "spec/**/*_spec.rb"
end
