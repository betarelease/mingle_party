# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler/version'

Gem::Specification.new do |s|
  s.name        = "mingle_party"
  s.version     = "0.0.3"
  s.platform    = Gem::Platform::RUBY 
  s.authors     = ["betarelease"]
  s.email       = ["sudhindra.r.rao@gmail.com"]
  s.homepage    = "http://github.com/betarelease/mingle_party"
  s.summary     = %q{A gem to consume Mingle API using HTTParty}
  s.description = %q{An example implementation that demonstrates how to use Mingle API}

  s.rubyforge_project = "mingle_party"

  s.files       = Dir.glob("{bin,lib}/**/*") + %w(README.md)
  s.require_path = "lib"

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "crack"
  s.add_runtime_dependency "httparty"
end
