# -*- encoding: utf-8 -*-
# stub: cool.io 1.5.3 x64-mingw32 lib

Gem::Specification.new do |s|
  s.name = "cool.io".freeze
  s.version = "1.5.3"
  s.platform = "x64-mingw32".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tony Arcieri".freeze, "Masahiro Nakagawa".freeze]
  s.date = "2017-11-22"
  s.description = "Cool.io provides a high performance event framework for Ruby which uses the libev C library".freeze
  s.email = ["tony.arcieri@gmail.com".freeze, "repeatedly@gmail.com".freeze]
  s.homepage = "http://coolio.github.com".freeze
  s.required_ruby_version = Gem::Requirement.new(["< 2.5".freeze, ">= 2.0".freeze])
  s.rubygems_version = "2.6.11".freeze
  s.summary = "A cool framework for doing high performance I/O in Ruby".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.6.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 2.13.0"])
      s.add_development_dependency(%q<rdoc>.freeze, [">= 3.6.0"])
    else
      s.add_dependency(%q<rake-compiler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.6.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 2.13.0"])
      s.add_dependency(%q<rdoc>.freeze, [">= 3.6.0"])
    end
  else
    s.add_dependency(%q<rake-compiler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.6.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 2.13.0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 3.6.0"])
  end
end
