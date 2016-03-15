require 'sinatra/base'
require 'sinatra/activerecord'
require 'erb'
require 'sinatra/config_file'
require 'yajl'
require 'omniauth'
require 'omniauth-google-oauth2'

# Load models, routes
# App is a Sinatra app example
class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::ConfigFile

  config_file File.join('config', 'config.yml')

  # Load models, routes
  Dir[File.join('models', '*.rb')].each { |file| require_relative file }
  Dir[File.join('routes', '*.rb')].each { |file| require_relative file }

  configure :production do
    enable :sessions
    enable :logging
    enable :method_override
    set :clean_trace, true
    use Rack::CommonLogger
  end

  configure :development, :test do
    enable :sessions
    enable :logging
    enable :method_override
    set :clean_trace, false
    use Rack::CommonLogger
  end

  use OmniAuth::Builder do
    provider :google_oauth2,
             ENV['GOOGLE_CLIENT_ID'],
             ENV['GOOGLE_CLIENT_SECRET'],
             scope: 'email,profile',
             hd: 'pagerduty.com',
             skip_image_info: false
  end

  before do
    @user = session['user'] if current_user
    @apikey
  end

  helpers do
    def current_user
      !session[:uid].nil?
    end

    def authenticate!
      # Check if using token auth, otherwise try OAuth
      key = ApiKey.find_by_identifier(request.env['HTTP_ACCESS_IDENTIFIER'])
      if key
        @apikey = key
        unless key.password == request.env['HTTP_ACCESS_TOKEN']
          halt 401, "Not Authorized\n"
        end
      else
        halt 401, "Not Authorized\n" unless current_user
      end
    end

    def fd(date)
      date.strftime('%F %T')
    end

    alias_method :h, :escape_html
    alias_method :u, :escape
  end

  set :views, File.join(File.dirname(__FILE__), 'views')
end
