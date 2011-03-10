# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{platybox}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Roberto Calderon"]
  s.date = %q{2011-03-09}
  s.description = %q{The platybox API gem}
  s.email = %q{roberto @ robertocalderon.ca}
  s.extra_rdoc_files = ["lib/platybox.rb"]
  s.files = ["Rakefile", "lib/platybox.rb", "Manifest", "platybox.gemspec"]
  s.homepage = %q{http://github.com/calderonroberto/platybox}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Platybox", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{platybox}
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{This gem provides easy interaction with the Platybox API}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<oauth>, [">= 0.4.3"])
      s.add_development_dependency(%q<omniauth>, [">= 0.2.0.beta5"])
    else
      s.add_dependency(%q<oauth>, [">= 0.4.3"])
      s.add_dependency(%q<omniauth>, [">= 0.2.0.beta5"])
    end
  else
    s.add_dependency(%q<oauth>, [">= 0.4.3"])
    s.add_dependency(%q<omniauth>, [">= 0.2.0.beta5"])
  end
end
