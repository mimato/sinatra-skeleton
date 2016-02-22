require 'spec_helper'

describe App do
  describe 'hello endpoint' do
    it 'returns hello world' do
      get '/hello'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Hello world, it')
    end
  end
end
