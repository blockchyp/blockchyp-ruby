# frozen_string_literal: true

require 'bundler/gem_tasks'

begin
  Bundler.setup(:default)
rescue Bundler::BundlerError => e
  warn e.message
  warn 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'
require 'rake/testtask'

task(default: %i[test lint])

Rake::TestTask.new(:test) do |t|
  t.libs << '.' << 'lib' << 'test'
  t.test_files = FileList['test/*_test.rb']
  t.verbose = false
end

task :lint do
  if RUBY_ENGINE == 'ruby'
    require 'rubocop/rake_task'
    RuboCop::RakeTask.new
  end
end

task(gem: :build)
task :build do
  system 'gem build blockchyp.gemspec'
end

task publish: :build do
  system "gem push blockchyp-#{BlockChyp::VERSION}.gem"
  system "rm blockchyp-#{BlockChyp::VERSION}.gem"
end
