# -*- encoding: utf-8 -*-
# stub: skyblue-rails 0.0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "skyblue-rails".freeze
  s.version = "0.0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["zmpeg".freeze]
  s.date = "2015-03-10"
  s.description = "This gem provides SkyBlue CSS Framework assets for rails 4+.".freeze
  s.email = ["zandstra.matt@gmail.com".freeze]
  s.homepage = "https://github.com/zmpeg/skyblue-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.2".freeze
  s.summary = "SkyBlue CSS with rails 4+".freeze

  s.installed_by_version = "3.0.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1.0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.8"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.1.0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.8"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1.0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.8"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
