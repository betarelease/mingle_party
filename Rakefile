require "bundler/gem_tasks"
require "bundler/version"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :build

task :build do
  system "gem build mingle_party.gemspec"
end
 
task :release => :build do
  system "gem push mingle_party-0.0.3"
end