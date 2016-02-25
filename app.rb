require 'sinatra/base'
require 'sinatra/activerecord'
require 'erb'
require 'sinatra/config_file'


# Load models, routes
# App is a Sinatra app example
class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::ConfigFile

  config_file File.join('config', 'config.yml')

  Dir[File.join('models', '*.rb')].each { |file| require_relative file }
  Dir[File.join('routes', '*.rb')].each { |file| require_relative file }

  configure :production do
    enable :logging
    set :clean_trace, true
    file = File.new(CONFIG['log_file'], 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  configure :development, :test do
    enable :logging
    set :clean_trace, false
  end

  before do
    logger.level = 0
  end

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
    alias_method :u, :escape
  end

  set :views, File.join(File.dirname(__FILE__), 'views')
end
