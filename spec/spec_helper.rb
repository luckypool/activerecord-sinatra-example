require 'rspec'
require "database_cleaner"

ENV["RACK_ENV"] = "test"

require_relative "../app"

RSpec.configure do |config|
  config.order = 'random'

  ActiveRecord::Base.logger = nil

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
