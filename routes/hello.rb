# /hello endpoint class, returns hello world
class App < Sinatra::Base
  get '/hello' do
    authenticate!
    "Hello world, it's #{Time.now} at the server!"
  end
end
