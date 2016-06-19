require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  context 'swagger documentation root' do
    before do
      get '/api/swagger_doc'
      expect(last_response.status).to eq(200)
      @json = JSON.parse(last_response.body, symbolize_names: true)
    end

    it 'exposes api version' do
      expect(@json[:info][:version]).to eq('0.0.1')
      expect(@json[:paths].size).to be > 10
    end
  end

  context 'swagger documentation api' do
    before do
      get '/api/swagger_doc'
      expect(last_response.status).to eq(200)
      @apis = JSON.parse(last_response.body, symbolize_names: true)[:paths]
    end
  end

  context 'swagger entity documentation api' do
    before do
      get '/api/swagger_doc/entities'
      expect(last_response.status).to eq(200)
      @apis = JSON.parse(last_response.body, symbolize_names: true)
    end

    it 'exposes entity documentation' do
      entity = @apis[:paths][:"/api/entities/{id}"]

      expect(entity.keys.length).to eql 1
      expect(entity).to include :get

      parameters = Hash[entity[:get][:parameters].map { |parameter| [parameter[:name], parameter[:description]] }]
      expect(parameters).to eq('id' => nil,
                               'length' => 'length of the tool',
                               'weight' => 'weight of the tool',
                               'foo' => 'foo')
      definitions = @apis[:definitions]
      expect(definitions).to include :Tool
    end
  end
end
