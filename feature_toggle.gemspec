require 'rake/gempackagetask'

Gem::Specification.new do |s|
  s.name = "feature_toggle"
  s.version = "0.0.1"

  s.authors = ["Mingle SaaS team"]
  s.email = %q{mingle.saas@thoughtworks.com}

  s.homepage = %q{https://github.com/ThoughtWorksStudios/feature_toggle}
  s.require_paths = ["lib"]
  s.summary = "Feature Toggle library for ruby"
  s.files = FileList["{lib,test}/**/*"].exclude("rdoc").to_a + ["Rakefile", "README.md", "CHANGELOG.md"]
end
