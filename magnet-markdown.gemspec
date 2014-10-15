# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'magnet/markdown/version'

Gem::Specification.new do |spec|
  spec.name          = "magnet-markdown"
  spec.version       = Magnet::Markdown::VERSION
  spec.authors       = ["Sho Kusano"]
  spec.email         = ["sho-kusano@mgnt-inc.jp"]
  spec.summary       = %q{Magnet specified markdown processor}
  spec.homepage      = "https://github.com/magnet-inc/magnet-markdown"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'github-markdown'
  spec.add_dependency 'sanitize'
  spec.add_dependency 'gemoji'
  spec.add_dependency 'rinku'
  spec.add_dependency 'html-pipeline'
end
