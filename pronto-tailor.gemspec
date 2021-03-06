# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pronto/tailor/version'

Gem::Specification.new do |spec|
  spec.name          = "pronto-tailor"
  spec.version       = Pronto::Tailor::VERSION
  spec.authors       = ["Andrius Janauskas"]
  spec.email         = ["andrius.janauskas@gmail.com"]
  spec.homepage      = 'https://github.com/ajanauskas/pronto-tailor'

  spec.summary       = 'Pronto runner for Tailor, swift code analyzer'
  spec.description   = <<-EOF
    A pronto runner for Tailor - Swift code analyzer. Pronto runs analysis quickly by checking only
    the relevant changes. Created to be used on pull requests, but suited for other scenarios as well. Perfect
    if you want to find out quickly if branch introduces changes that conform to
    your styleguide, are DRY, don't introduce security holes and more.
  EOF
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'pronto', '~> 0.5.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
end
