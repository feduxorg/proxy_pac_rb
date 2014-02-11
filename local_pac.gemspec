# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'local_pac/version'

Gem::Specification.new do |spec|
  spec.name          = "local_pac"
  spec.version       = LocalPac::VERSION
  spec.authors       = ["Dennis Günnewig"]
  spec.email         = ["dg1@vrnetze.de"]
  spec.summary       = %q{Serve local proxy pac}
  spec.description   = <<-EOS
This gem helps you to serve proxy.pacs locallly
EOS
  spec.homepage      = "https://github.com/dg-vrnetze/local_pac"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'sinatra'
  spec.add_runtime_dependency 'thor'
end
