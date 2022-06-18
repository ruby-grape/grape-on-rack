require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'uploads and downloads a PNG file' do
    image_filename = 'spec/fixtures/grape_logo.png'
    post '/api/big_download.png', file: Rack::Test::UploadedFile.new(image_filename, 'image/png', true)
    expect(last_response.status).to eq(201)
    expect(last_response.headers['Content-Type']).to eq('image/png')
    expect(last_response.headers['Content-Disposition']).to eq("attachment; filename*=UTF-8''grape_logo.png")
    data = File.read(image_filename, encoding: 'UTF-8')
    expect(last_response.body.encoding).to eq data.encoding
    expect(last_response.body).to eq data
  end
end
