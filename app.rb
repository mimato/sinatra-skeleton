require 'sinatra/base'
require 'sinatra/activerecord'

# Load models, routes
Dir[File.join('models', '*.rb')].each { |file| require_relative file }
Dir[File.join('routes', '*.rb')].each { |file| require_relative file }

CONFIG = YAML.load_file(File.join('config', 'config.yml'))[:environment]

# App is a Sinatra app example
class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension

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
end
