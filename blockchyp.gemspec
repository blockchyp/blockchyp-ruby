# frozen_string_literal: true

$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

Gem::Specification.new do |s|
  s.name = "blockchyp"
  s.version = "1.4.0"
  s.required_ruby_version = ">= 2.3.0"
  s.summary = "BlockChyp Ruby SDK"
  s.author = "BlockChyp"
  s.homepage = "https://github.com/blockchyp/blockchyp-ruby"
  s.license = "MIT"
  s.metadata = {
    "github_repo" => "ssh://github.com/blockchyp/blockchyp-ruby"
  }

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]
end
