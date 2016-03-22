# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dk_codebreaker/version'

Gem::Specification.new do |spec|
  spec.name          = "dk_codebreaker"
  spec.version       = DkCodebreaker::VERSION
  spec.authors       = ["Den Key"]
  spec.email         = ["denis.kryukov@aol.com"]

  spec.summary       = %q{Codebreaker is a logic game.}
  spec.description   = %q{Codebreaker is a logic game in which a code-breaker tries to break a secret code created by a code-maker.
                          The code-maker, which will be played by the application we’re going to write, 
                          creates a secret code of four numbers between 1 and 6.}
  spec.homepage      = "https://github.com/DenKey/dk_codebreaker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11.2"
  spec.add_development_dependency "rake", "~> 10.5.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "rspec-collection_matchers", "~> 1.1", ">= 1.1.2"
end
