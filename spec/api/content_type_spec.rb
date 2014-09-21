require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  context 'plain_text' do
    it 'returns plain text' do
      get '/api/plain_text'
      expect(last_response.status).to eq(200)
      expect(last_response.headers['Content-Type']).to eq('text/plain')
      expect(last_response.body).to eq('A red brown fox jumped over the road.')
    end
  end

  context 'mixed' do
    it 'returns json' do
      get '/api/mixed.json'
      expect(last_response.status).to eq(200)
      expect(last_response.headers['Content-Type']).to eq('application/json')
      expect(last_response.body).to eq({ data: 'A red brown fox jumped over the road.' }.to_json)
    end

    it 'returns xml' do
      get '/api/mixed.xml'
      expect(last_response.status).to eq(200)
      expect(last_response.headers['Content-Type']).to eq('application/xml')
      expect(last_response.body).to eq({ data: 'A red brown fox jumped over the road.' }.to_xml)
    end

    it 'returns text' do
      get '/api/mixed.txt'
      expect(last_response.status).to eq(200)
      expect(last_response.headers['Content-Type']).to eq('text/plain')
      expect(last_response.body).to eq({ data: 'A red brown fox jumped over the road.' }.to_s)
    end
  end
end
