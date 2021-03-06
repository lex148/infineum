# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "infineum/version"

Gem::Specification.new do |s|
  s.name        = "infineum"
  s.version     = Infineum::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = "http://rubygems.org/gems/infineum"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "infineum"
  s.add_dependency 'eventmachine', '0.12.10'
  s.add_dependency 'redis', '2.2.0'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
