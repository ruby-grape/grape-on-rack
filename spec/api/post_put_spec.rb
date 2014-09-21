require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'GET ring' do
    get '/api/ring'
    expect(JSON.parse(last_response.body)[:rang].to_i).to be >= 0
  end
  context 'with rings' do
    before :each do
      get '/api/ring'
      @rang = JSON.parse(last_response.body)['rang'].to_i
    end
    it 'POST ring' do
      2.times do |i|
        post '/api/ring'
        expect(last_response.status).to eq(201)
        expect(last_response.body).to eq({ rang: @rang + i + 1 }.to_json)
      end
      get '/api/ring'
      expect(last_response.body).to eq({ rang: @rang + 2 }.to_json)
    end
    context 'PUT ring' do
      it 'succeeds for 2 rings' do
        put '/api/ring?count=2'
        expect(last_response.status).to eq(200)
        expect(last_response.body).to eq({ rang: @rang + 2 }.to_json)
      end
      it 'fails with a missing ring' do
        put '/api/ring'
        expect(last_response.status).to eq(400)
        expect(last_response.body).to eq({ error: 'count is missing' }.to_json)
      end
    end
  end
end
