$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "delivery_uncle/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "delivery_uncle"
  s.version     = DeliveryUncle::VERSION
  s.authors     = ["Alvin S.J. Ng"]
  s.email       = ["email.to.alvin@gmail.com"]
  s.homepage    = "http://github.com/alvinsj/delivery_uncle"
  s.summary     = "A Rails Engine that you can hired to manage emailing"
  s.description = "A Rails Engine that you can hired to manage emailing"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.12"
  s.add_dependency "resque"
  s.add_dependency "resque-loner"
  s.add_dependency "resque-history"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "factory_girl_rails"
end
