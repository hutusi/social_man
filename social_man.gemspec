$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "social_man/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "social_man"
  s.version     = SocialMan::VERSION
  s.authors     = ["John Hu"]
  s.email       = ["huziyong@gmail.com"]
 
  s.summary       = %q{Follow, star, vote, like, social actions all in one.}
  s.description   = %q{Follow, star, vote, like, social actions all in one.}
  s.homepage      = "https://github.com/hutusi/social_man/"
  s.license       = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "bundler", "~> 1.16"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rspec-its"
  s.add_development_dependency "factory_bot"
end
