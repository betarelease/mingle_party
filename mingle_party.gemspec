# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mingle_party"
  s.version     = "0.0.1" 
  s.authors     = ["betarelease"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{A gem to consume Mingle API using HTTParty}
  s.description = %q{An example implementation that demonstrates how to use Mingle API}

  s.rubyforge_project = "mingle_party"

  s.files         = `git ls-files 2> /dev/null`.split("\n")
  s.test_files    = `git ls-files -- {spec}/* 2> /dev/null`.split("\n")
  s.executables   = `git ls-files -- bin/* 2> /dev/null`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "crack"
  s.add_runtime_dependency "httparty"
end
