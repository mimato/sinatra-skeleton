# Endpoints dealing with API Keys
class App < Sinatra::Base
  get '/apikeys' do
    authenticate!
    # List API Keys
    apikeys = ApiKey.where('user_id = ?', session['user'].id)
    # apikeys = ApiKey.all
    erb :'apikeys/list', locals: { apikeys: apikeys }
  end

  get '/apikeys/new' do
    authenticate!
    # Get input for new API key
    erb :'apikeys/new', locals: {}
  end

  post '/apikeys' do
    authenticate!
    # Expects name param from form
    # Create new api key
    key = SecureRandom.urlsafe_base64(30, false)
    identifier = SecureRandom.urlsafe_base64(15, false)
    apikey = ApiKey.create(
      user: session['user'],
      name: params[:keyname],
      identifier: identifier
    )
    redirect '/apikeys/new' unless apikey.valid?
    apikey.password = key
    apikey.save!
    halt 500 unless apikey
    erb :'apikeys/show', locals: {
      name: apikey.name,
      identifier: apikey.identifier,
      key: key
    }
  end

  delete '/apikeys/:id' do |id|
    authenticate!
    ApiKey.find(id).destroy
    redirect '/apikeys'
  end
end
