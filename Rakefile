require "bundler/setup"
require "sinatra/activerecord/rake"

require_relative "app"

ENV["RACK_ENV"] ||= "development"

ActiveRecord::Tasks::DatabaseTasks.db_dir = './db'
ActiveRecord::Tasks::DatabaseTasks.root   = './'

task :default => [:spec]
task :spec do
  sh "rspec"
end
