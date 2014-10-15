require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rake/testtask'

Rubocop::RakeTask.new

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*test.rb']
  t.verbose = true
end

task default: %i(rubocop test)
