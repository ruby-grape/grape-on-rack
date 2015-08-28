require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'flips reticulated in a collection of splines' do
    get '/api/reticulated_splines', 'splines' => [
      { id: 1, reticulated: false },
      { id: 2, reticulated: true }
    ].to_json
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq([
      { id: 1, reticulated: true },
      { id: 2, reticulated: false }
    ].to_json)
  end
end
