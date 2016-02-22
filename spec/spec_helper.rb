# -*- coding: UTF-8 -*-
ENV['RACK_ENV'] = 'test'

require 'database_cleaner'
require 'factory_girl'
require 'rack/test'
require 'sinatra'
require 'sinatra/activerecord'

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

FactoryGirl.definition_file_paths = %w(./spec/factories)
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

ActiveRecord::Base.logger = nil # 'Cause we're in test here
load(File.join(File.dirname(__FILE__), '..', 'db', 'schema.rb'))

require File.join(File.dirname(__FILE__), '..', 'app.rb')

def app
  App
end
