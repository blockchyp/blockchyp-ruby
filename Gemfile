# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'rake', '~> 12.0'
gem 'rspec', '~> 3.7'
gem 'rubocop-rspec', '~> 1.33.0'
gem 'test-unit'

local_gemfile = File.expand_path('Gemfile.local', __dir__)
eval_gemfile local_gemfile if File.exist?(local_gemfile)
