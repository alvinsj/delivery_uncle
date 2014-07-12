$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "delivery_uncle/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "delivery_uncle"
  s.version     = DeliveryUncle::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of DeliveryUncle."
  s.description = "TODO: Description of DeliveryUncle."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.4"

  s.add_development_dependency "pg"
end
