# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blockchyp/version'

Gem::Specification.new do |spec|
  spec.name = 'blockchyp'
  spec.version = BlockChyp::VERSION
  spec.required_ruby_version = '>= 2.3.0'
  spec.summary = 'BlockChyp Ruby SDK'
  spec.author = 'BlockChyp'
  spec.homepage = 'https://github.com/blockchyp/blockchyp-ruby'
  spec.license = 'MIT'
  spec.metadata = {
    'github_repo' => 'ssh://github.com/blockchyp/blockchyp-ruby.git'
  }
  spec.files = Dir['{test,lib}/**/*'] + ['Rakefile', 'README.md', 'Makefile']
  spec.require_paths = ['lib']
end
