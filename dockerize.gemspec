
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dockerize/version"

Gem::Specification.new do |spec|
  spec.name          = "dockerize"
  spec.version       = Dockerize::VERSION
  spec.authors       = ["Anton Bozhinov"]
  spec.email         = ["anton.bozhinov@gmail.com"]

  spec.summary       = %q{Create dockerized apps}
  spec.description   = %q{Generates a docker-compose file with app and given database}
  spec.homepage      = "https://github.com/AntonBozhinov/dockerize"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = "exe"
  spec.executables   = ["dockerize"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "thor"
end
