# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rateable/version"

Gem::Specification.new do |s|
  s.name        = "rateable"
  s.version     = Rateable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["André Domnick"]
  s.email       = ["andre@paniccrew.de"]
  s.homepage    = ""
  s.summary     = %q{Add a stars rating to your models}
  s.description = %q{A way for simply adding an ajax rating to any of your models}

  s.rubyforge_project = "glynx_rateable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
