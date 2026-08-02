require 'spec_helper'

describe Acme::API do
  include Rack::Test::Methods

  def app
    Acme::API
  end

  it 'streams the upload and download of a large PNG file' do
    image_filename = 'spec/fixtures/grape_logo.png'
    post '/api/download_stream', file: Rack::Test::UploadedFile.new(image_filename, 'image/png', true)
    expect(last_response.status).to eq(201)
    expect(last_response.headers['Content-Type']).to eq('image/png')
    expect(last_response.headers['Content-Disposition']).to eq("attachment; filename*=UTF-8''grape_logo.png")
    File.open(image_filename, 'rb') do |io|
      expect(last_response.body).to eq io.read
    end
  end
end
