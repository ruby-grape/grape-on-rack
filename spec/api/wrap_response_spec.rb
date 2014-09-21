require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'wraps body' do
    get '/api/decorated/ping'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to eq('body' => { 'ping' => 'pong' }, 'status' => 200)
  end
end
