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
  s.summary     = "Rails Engine that you can hire to manage your outgoing email"
  s.description = "Rails Engine that you can hire to manage your outgoing email"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.12"
  s.add_dependency "resque", "~> 1.21"

  s.add_development_dependency "sqlite3", "~> 1.3"
  s.add_development_dependency "rspec-rails", "~> 2.14"
  s.add_development_dependency "resque_spec", "~> 0.15"
end
