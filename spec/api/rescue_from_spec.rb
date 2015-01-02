require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'rescues all exceptions' do
    get '/api/raise'
    expect(last_response.status).to eq(500)
    expect(last_response.body).to eq('Unexpected error.')
  end
end
