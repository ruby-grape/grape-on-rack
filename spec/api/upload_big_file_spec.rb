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

  it 'streams the upload and download of a large Ruby file' do
    filename = __FILE__
    post '/api/download_stream', file: Rack::Test::UploadedFile.new(filename, 'application/x-ruby', true)
    expect(last_response.status).to eq(201)
    expect(last_response.headers['Content-Type']).to eq('application/x-ruby')
    expect(last_response.headers['Content-Disposition']).to eq("attachment; filename*=UTF-8''upload_big_file_spec.rb")
    File.open(filename, 'rb') do |io|
      expect(last_response.body).to eq io.read
    end
  end
end
