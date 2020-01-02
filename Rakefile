require 'rake/testtask'

task default: %w[test]

task :test do
  Rake::TestTask.new do |t|
    t.libs = ["lib"]
    t.test_files = FileList['test/*_test.rb']
  end
end
