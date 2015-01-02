require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'returns exposed entity' do
    get '/api/entities/123'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to eq(
      'tool' => {
        'id' => '123',
        'length' => 10,
        'weight' => '20kg'
      }
    )
  end

  it 'returns exposed entity with options' do
    get '/api/entities/123?foo=bar'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body)).to eq(
      'tool' => {
        'id' => '123',
        'length' => 10,
        'weight' => '20kg',
        'foo' => 'bar'
      }
    )
  end

  it 'uses a custom formatter to reset xml root' do
    get '/api/entities/123.xml?foo=bar'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<tool>
  <id>123</id>
  <length type="integer">10</length>
  <weight>20kg</weight>
  <foo>bar</foo>
</tool>
XML
  end
end
