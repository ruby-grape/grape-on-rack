require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'returns all headers' do
    get '/api/headers'
    expect(JSON.parse(last_response.body)).to eq(
      'Cookie' => '',
      'Host' => 'example.org',
      'Version' => 'HTTP/1.0'
    )
  end

  it 'returns a Host header' do
    get '/api/headers/Host'
    expect(JSON.parse(last_response.body)).to eq('Host' => 'example.org')
  end

  it 'headers are converted to pascal-case' do
    get '/api/headers/Host'
    expect(JSON.parse(last_response.body)).to eq('Host' => 'example.org')
  end

  it 'headers via Rack::Test API' do
    header 'Reticulated-Spline', 42
    get '/api/headers/Reticulated-Spline'
    expect(JSON.parse(last_response.body)).to eq('Reticulated-Spline' => 42)
  end

  it 'headers via arg' do
    get '/api/headers', nil,
        'HTTP_RETICULATED_SPLINE' => 42,
        'SOMETHING_ELSE' => 1
    expect(JSON.parse(last_response.body)).to eq(
      'Cookie' => '',
      'Host' => 'example.org',
      'Reticulated-Spline' => 42,
      'Version' => 'HTTP/1.0'
    )
  end
end
