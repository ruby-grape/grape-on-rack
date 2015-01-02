require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'vendored path' do
    get '/api/vendor'
    expect(last_response.body).to eq({ path: 'acme' }.to_json)
  end
end
