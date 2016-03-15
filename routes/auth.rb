require 'json'

# Authentication
class App < Sinatra::Base
  get '/auth/:provider/callback' do
    session['uid'] = env['omniauth.auth']['uid']
    session['user'] = User.find_or_create_by(
      email: request.env['omniauth.auth'][:info][:email]
    ) do |user|
      user.name = request.env['omniauth.auth'][:info][:name]
    end
    @user = session['user']
    redirect '/'
  end

  get '/auth/failure' do
    @message = 'Authentication Failed'
    erb :'auth/failure'
  end

  get '/auth/logout' do
    session.clear
    redirect '/'
  end

  get '/auth/:provider/deauthorized' do
    @message = "#{params[:provider]} has deauthorized this app"
    erb :'auth/failure'
  end
end
