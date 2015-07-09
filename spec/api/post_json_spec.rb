require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  [true, false].each do |reticulated|
    it "POST #{reticulated ? 'reticulated' : 'unreticulated'} spline" do
      post '/api/spline', 'reticulated' => reticulated
      expect(last_response.status).to eq(201)
      expect(JSON.parse(last_response.body)).to eq('reticulated' => reticulated.to_s)
    end
  end
end
