# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pastebin}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["dougsko"]
  s.date = %q{2009-06-23}
  s.default_executable = %q{pastebin}
  s.description = %q{Command line interface to http://pastebin.ca}
  s.email = %q{dougtko@gmail.com}
  s.executables = ["pastebin"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/pastebin",
     "pastebin.gemspec",
     "spec/pastebin_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/dougsko/pastebin}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["/bin"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Command line interface to http://pastebin.ca}
  s.test_files = [
    "spec/pastebin_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httpclient>, [">= 0"])
    else
      s.add_dependency(%q<httpclient>, [">= 0"])
    end
  else
    s.add_dependency(%q<httpclient>, [">= 0"])
  end
end
