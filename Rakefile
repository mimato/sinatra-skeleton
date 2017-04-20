require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'sinatra/activerecord/rake'

require_relative 'app'

RSpec::Core::RakeTask.new(:spec)

desc 'rubocop compliancy checks'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns = %w[Rakefile Gemfile models/**/*.rb
                  routes/**/*.rb spec/**/*.rb lib/**/*.rb]
  t.fail_on_error = true
end

task default: %i[spec rubocop]
