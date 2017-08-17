# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sei/version'

Gem::Specification.new do |spec|
  spec.name          = "sei"
  spec.version       = Sei::VERSION
  spec.authors       = ["Leandro Telles"]
  spec.email         = ["tellesleandro@gmail.com"]

  spec.summary       = "Integração com a API do SEI."
  spec.description   = "Expõe, através de métodos ruby, as funcionalidades da API do SEI."
  spec.homepage      = "https://github.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'byebug'
  spec.add_runtime_dependency 'gem_config'
  spec.add_runtime_dependency 'savon'
  spec.add_runtime_dependency 'valuable'
  spec.add_runtime_dependency 'http'
  spec.add_runtime_dependency 'plissken'
  spec.add_runtime_dependency 'facets'
end
