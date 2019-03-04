$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pixeladmin_tabs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pixeladmin_tabs"
  s.version     = PixeladminTabs::VERSION
  s.authors     = ["Tom Maeckelberghe"]
  s.email       = ["tom.maeckelberghe@gmail.com"]
  s.homepage    = "https://www.qmusic.be"
  s.summary     = "Add pixeladmin tabs to panel"
  s.description = "Needs pixeladmin"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 3.2.0"
end
