require "bundler/setup"
require "sinatra/activerecord/rake"

require_relative "app"

ENV["RACK_ENV"] ||= "development"

task :default => [:spec]
task :spec do
  ENV["RACK_ENV"] = "test"
  sh "rake db:schema:load"
  sh "rspec"
end
