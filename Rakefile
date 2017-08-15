require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test

task :servicos do
  require 'sei'
  puts "Serviços implementados:\n\n"
  Sei::V3::Servicos::Base.all_services.each do |service|
    puts service.name.split('::').last
  end
end
