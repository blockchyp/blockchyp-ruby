# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "blockchyp"
  s.version = "2.0.0"
  s.required_ruby_version = ">= 2.3.0"
  s.summary = "BlockChyp Ruby SDK"
  s.author = "BlockChyp"
  s.homepage = "https://github.com/blockchyp/blockchyp-ruby"
  s.license = "MIT"
  s.metadata = {
    "github_repo" => "ssh://github.com/blockchyp/blockchyp-ruby.git"
  }
  s.files = Dir["{test,lib}/**/*"] + ["Rakefile", "README.md", "Makefile"]
  s.require_paths = ["lib"]
end
