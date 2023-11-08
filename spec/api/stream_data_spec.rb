require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'returns all data' do
    get '/api/stream'
    expect(last_response.status).to eq(200)
    expect(last_response.instance_variable_get(:@body)).to eq(%W[1\n 2\n 3\n 4\n 5\n])
    expect(last_response.body).to eq("1\n2\n3\n4\n5\n")
    expect(last_response.content_type).to eq('text/event-stream')
  end
end
