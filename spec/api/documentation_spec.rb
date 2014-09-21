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
      @json = JSON.parse(last_response.body)
    end

    it 'exposes api version' do
      expect(@json['apiVersion']).to eq('v1')
      expect(@json['apis'].size).to be > 10
    end
  end

  context 'swagger documentation api' do
    before do
      get '/api/swagger_doc'
      expect(last_response.status).to eq(200)
      @apis = JSON.parse(last_response.body)['apis']
    end
  end

  context 'swagger entity documentation api' do
    before do
      get '/api/swagger_doc/entities'
      expect(last_response.status).to eq(200)
      @apis = JSON.parse(last_response.body)['apis']
    end

    it 'exposes entity documentation' do
      entities = @apis.find { |api| api['path'] == '/api/entities/{id}.{format}' }
      operations = entities['operations']
      expect(operations.size).to eq(1)
      parameters = Hash[operations.first['parameters'].map { |parameter| [parameter['name'], parameter['description']] }]
      expect(parameters).to eq('id' => '',
                               'length' => 'length of the tool',
                               'weight' => 'weight of the tool',
                               'foo' => 'foo')
    end
  end
end
